class OrchestraController < NavigationController

  def index
  end

  def register
    return if require_login!

    @isLintek = current_user['is_lintek_member']

    @ticketText = ["Torsdag (11/5) - Söndag (14/5)", "Fredag (12/5) - Söndag (14/5)", "Lördag (13/5) - Söndag (15/5)", "Ingen biljett"]
    if @isLintek
      @ticketCostStr = [" (435kr)", " (410kr)", " (190kr)", " (0kr)"]
      @ticketCost = (0..3).to_a
    else
      @ticketCostStr = [" (535kr)", " (510kr)", " (220kr)", " (0kr)"]
      @ticketCost = (0..3).to_a
    end

    @ticketOpt = [["", ""], ["", ""], ["", ""], ["", ""]]

    for i in 0..3
      @ticketOpt[i][0] = @ticketText[i] + @ticketCostStr[i]
      @ticketOpt[i][1] = @ticketCost[i]
    end

    if request.post?
      item_params = orchestra_signup_params
      response = database.create_orchestra_signup(item_params)
      if response.success?
        flash[:success] = 'Anmäld till orkester'
        redirect_to action: :show_signup, id: response['id']
      else
        flash.now[:error] = 'Kunde inte skapa anmälan'
      end
    end
  end

  def create
    return if require_login!

    if request.post?
      response = database.create_orchestra(orchestra_params)
      if response.success?
        redirect_to action: :show, id: response['id']
      else
        flash.now[:error] = 'Kunde inte skapa orkester'
      end
    end
  end

  def update
    return if require_login!

    response = database.update_orchestra(params[:id], orchestra_params)
    if response.success?
      flash[:success] = 'Orkester uppdaterad'
    else
      flash[:error] = 'Kunde inte uppdatera orkester'
    end

    redirect_to action: :show, id: params[:id]
  end

  def show
    return if require_login!

    @orchestra = database.show_orchestra params[:id]
    unless @orchestra.success?
      flash[:error] = 'Kunde inte hitta orkester'
      redirect_to '/'
    end
  end

  def show_signup
    return if require_login!

    @signup = database.show_orchestra_signup params[:id]
    unless @signup.success?
      flash[:error] = 'Kunde inte hitta anmälan'
      redirect_to '/'
    end

    @isLintek = current_user['is_lintek_member']
    @ticketText = ["Torsdag - Söndag", "Fredag - Söndag", "Lördag - Söndag", "Ingen biljett"]

    # Festivalbiljett
    @festivalTicketID = @signup["orchestra_ticket"]["kind"]
    if @isLintek
      @ticketCostStr = ["435", "410", "190", "0"]
    else
      @ticketCostStr = ["535", "510", "220", "0"]
    end
    @festivalTicket = @ticketText[@festivalTicketID]
    @ticketCost = @ticketCostStr[@festivalTicketID]

    # Matbiljett
    @foodTicketID = @signup["orchestra_food_ticket"]["kind"]
    @foodTicket = @ticketText[@foodTicketID]
    @foodTicketCost = ["215", "140", "75", "0"][@foodTicketID]

    # Övernattning
    if(@signup["dormitory"])
      @dormitory = 1
    else
      @dormitory = 1
    end

    @allTshirts = @signup["orchestra_articles"].select{|x| x["kind"]==1}
    @totalMedals = @signup["orchestra_articles"].select{|x| x["kind"]==2}.count
    @totalTags = @signup["orchestra_articles"].select{|x| x["kind"]==3}.count


    @totalCost = @ticketCost.to_i + @foodTicketCost.to_i + @dormitory * 50 + @allTshirts.count * 100 + @totalMedals* 40 + @totalTags* 20

    # "special_diets"
    @diets = @signup["special_diets"].map{|x| x["name"]}

    @otherPerformances = @signup["other_performances"]


  end

  def reset_code
    return if require_login!

    response = database.update_orchestra(params[:id], {item: {code: 'reset'}})
    if response.success?
      flash[:success] = 'Kod uppdaterad'
    else
      flash[:error] = 'Kunde inte skapa ny kod'
    end

    redirect_to action: :show, id: params[:id]
  end

  def delete
    return if require_login!

    response = database.delete_orchestra_signup(params[:id])
    if response.success?
      flash[:success] = 'Anmälan borttagen'
    else
      flash[:error] = 'Kunde inte ta bort anmälan'
    end

    redirect_to action: :register
  end

  def delete_orchestra
    return if require_login!

    response = database.delete_orchestra(params[:id])
    if response.success?
      flash[:success] = 'Orkester borttagen'
    else
      flash[:error] = 'Kunde inte ta bort orkester'
    end

    redirect_to action: :create
  end

  def verify_code
    return if require_login!

    response = database.verify_orchestra_code params[:code]
    if response.success?
      head :no_content
    else
      raise 'No match'
    end
  end

  private

  def orchestra_params
    {
        item: params.require(:item).permit(
            :name,
            :orchestra_type,
            :dormitory
        ).to_h
    }
  end

  def orchestra_signup_params
    {
        item: {
            code: params[:code],
            dormitory: dormitory,
            active_member: params[:active] == 'active',
            consecutive_10: params[:spree] == 'yes',
            attended_25: params['25years'] == 'yes',
            instrument_size: params['size-of-instrument'].to_i,
            orchestra_ticket_attributes:
                {
                    kind: params[:festival_ticket].to_i
                },
            orchestra_food_ticket_attributes:
                {
                    kind: params[:food_ticket].to_i
                },
            orchestra_articles_attributes: tshirts + medals + tags,
            special_diets_attributes: special_diet,
            other_performances: (params['otherPerformance-field'] unless params['otherPerformance-box'].nil?)
        }
    }
  end

  def tshirts
    (params[:tshirt] or []).map do |tshirt|
      {
          kind: 1,
          data: tshirt
      }
    end
  end

  def medals
    Array.new(params[:medals].to_i) { |_| {kind: 2} }
  end

  def tags
    Array.new(params[:tag].to_i) { |_| {kind: 3} }
  end

  def special_diet
    if params[:has_special_diet] and not params[:special_diets].nil?
      params[:special_diets].map { |x| {name: x}}
    else
      []
    end
  end

  def dormitory
    value = params[:sleep_over]
    if value == '0'
      nil
    elsif value == '1'
      true
    elsif value == '2'
      false
    end
  end
end
