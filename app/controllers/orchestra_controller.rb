class OrchestraController < NavigationController

  def index
  end

  def register
    return if require_login!

    @isLintek = current_user['is_lintek_member']

    @ticketText = ["Ingen biljett", "Torsdag (11/5) - Söndag (14/5)", "Fredag (12/5) - Söndag (14/5)", "Lördag (13/5) - Söndag (15/5)"]
    if @isLintek
      @ticketCostStr = [" (0kr)", " (435kr)", " (410kr)", " (190kr)"]
      @ticketCost = (0..3).to_a
    else
      @ticketCostStr = [" (0kr)", " (535kr)", " (510kr)", " (220kr)"]
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
            :ballet,
            :dormitory
        ).to_h
    }
  end

  def orchestra_signup_params
    {
        item: {
            code: params[:code],
            dormitory: params[:sleep_over] == '1',
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
                    kind: params[:food_ticket].to_i,
                    diet: (params[:specialfood] if params[:specialfood_on])
                },
            orchestra_articles_attributes: tshirts + medals + tags
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
end
