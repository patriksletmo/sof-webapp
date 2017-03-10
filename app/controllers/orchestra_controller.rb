class OrchestraController < NavigationController

  def index
  end

  def register
    return if require_login!

    @isLintek = current_user['is_lintek_member']

    @ticketText = [
        t('orchestra.register.festival_tickets.thursday.text'),
        t('orchestra.register.festival_tickets.friday.text'),
        t('orchestra.register.festival_tickets.saturday.text'),
        t('orchestra.register.festival_tickets.no_ticket.text')
    ]
    if @isLintek
      @ticketCostStr = [
          t('orchestra.register.festival_tickets.thursday.lintek_price'),
          t('orchestra.register.festival_tickets.friday.lintek_price'),
          t('orchestra.register.festival_tickets.saturday.lintek_price'),
          t('orchestra.register.festival_tickets.no_ticket.lintek_price')
      ]
      @ticketCost = (0..3).to_a
    else
      @ticketCostStr = [
          t('orchestra.register.festival_tickets.thursday.normal_price'),
          t('orchestra.register.festival_tickets.friday.normal_price'),
          t('orchestra.register.festival_tickets.saturday.normal_price'),
          t('orchestra.register.festival_tickets.no_ticket.normal_price')
      ]
      @ticketCost = (0..3).to_a
    end

    @ticketOpt = [["", ""], ["", ""], ["", ""], ["", ""]]

    for i in 0..3
      @ticketOpt[i][0] = @ticketText[i] + " (#{@ticketCostStr[i]})"
      @ticketOpt[i][1] = @ticketCost[i]
    end

    if request.post?
      item_params = orchestra_signup_params
      response = database.create_orchestra_signup(item_params)
      if response.success?
        flash[:success] = t('orchestra.messages.register.success')
        redirect_to action: :show_signup, id: response['id']
      else
        flash.now[:error] = t('orchestra.messages.register.failure')
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
        flash.now[:error] = t('orchestra.messages.create.failure')
      end
    end
  end

  def update
    return if require_login!

    response = database.update_orchestra(params[:id], orchestra_params)
    if response.success?
      flash[:success] = t('orchestra.messages.update.success')
    else
      flash[:error] = t('orchestra.messages.update.failure')
    end

    redirect_to action: :show, id: params[:id]
  end

  def show
    return if require_login!

    @orchestra = database.show_orchestra params[:id]
    unless @orchestra.success?
      flash[:error] = t('orchestra.messages.show.failure')
      redirect_to '/'
    end
    

    @orchestraSignups = database.all_orchestra_signups params[:id]

    respond_to do |format|
      format.html
      format.csv { send_data @orchestraSignups.encode('iso-8859-1'), :filename => "orkestersammanställning-#{Date.today}.csv", :type => 'text/csv; charset=iso-8859-1; header=present' }
    end
    
  end

  def show_signup
    return if require_login!

    @signup = database.show_orchestra_signup params[:id]
    unless @signup.success?
      flash[:error] = t('orchestra.messages.show_signup.failure')
      redirect_to '/'
    end

    @isLintek = current_user['is_lintek_member']
    @ticketText = [t('orchestra.register.festival_tickets.thursday.text_no_date'),
                   t('orchestra.register.festival_tickets.friday.text_no_date'),
                   t('orchestra.register.festival_tickets.saturday.text_no_date'),
                   t('orchestra.register.festival_tickets.no_ticket.text')]

    # Festivalbiljett
    @festivalTicketID = @signup["orchestra_ticket"]["kind"]



    @LintekDicounntCostStr = ["435", "410", "190", "0"]
    @ticketCostStr = ["535", "510", "220", "0"]

    @lintekDiscount = 0
    if(@isLintek)
      @lintekDiscount = @LintekDicounntCostStr[@festivalTicketID].to_i - @ticketCostStr[@festivalTicketID].to_i
    end

    @festivalTicket = @ticketText[@festivalTicketID]
    @ticketCost = @ticketCostStr[@festivalTicketID]


    @isLateRegistration = @signup["is_late_registration"]



    # Matbiljett
    @foodTicketID = @signup["orchestra_food_ticket"]["kind"]
    @foodTicket = @ticketText[@foodTicketID]
    @foodTicketCost = ["215", "140", "75", "0", "140"][@foodTicketID]

    # Övernattning
    if(@signup["dormitory"])
      @dormitory = 1
    else
      @dormitory = 0
    end

    @allTshirts = @signup["orchestra_articles"].select{|x| x["kind"]==1}
    @totalMedals = @signup["orchestra_articles"].select{|x| x["kind"]==2}.count
    @totalTags = @signup["orchestra_articles"].select{|x| x["kind"]==3}.count


    @totalCost = @ticketCost.to_i + @lintekDiscount + @foodTicketCost.to_i + @dormitory * 50 + @allTshirts.count * 100 + @totalMedals* 40 + @totalTags* 20

    # "special_diets"
    @diets = @signup["special_diets"].map{|x| x["name"]}

    @otherPerformances = @signup["other_performances"]


  end

  def reset_code
    return if require_login!

    response = database.update_orchestra(params[:id], {item: {code: 'reset'}})
    if response.success?
      flash[:success] = t('orchestra.messages.reset_code.success')
    else
      flash[:error] = t('orchestra.messages.reset_code.failure')
    end

    redirect_to action: :show, id: params[:id]
  end

  def delete
    return if require_login!

    response = database.delete_orchestra_signup(params[:id])
    if response.success?
      flash[:success] = t('orchestra.messages.delete.success')
    else
      flash[:error] = t('orchestra.messages.delete.failure')
    end

    redirect_to action: :register
  end

  def delete_orchestra
    return if require_login!

    response = database.delete_orchestra(params[:id])
    if response.success?
      flash[:success] = t('orchestra.messages.delete_orchestra.success')
    else
      flash[:error] = t('orchestra.messages.delete_orchestra.failure')
    end

    redirect_to action: :create
  end

  def verify_code
    return if require_login!

    response = database.verify_orchestra_code params[:code]
    if response.success?
      render :json => response
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
