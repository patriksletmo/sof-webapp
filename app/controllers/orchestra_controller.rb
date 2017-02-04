class OrchestraController < NavigationController

  def index

  end

  def register
    @isLintek = true

    @ticketText = ["Ingen biljett", "Torsdag (11/5) - Söndag (14/5)", "Fredag (12/5) - Söndag (14/5)", "Lördag (13/5) - Söndag (15/5)"]
    if @isLintek
        @ticketCost = [" (0kr)", " (435kr)", " (410kr)", " (190kr)"]
    else
      @ticketCost = [" (0kr)", " (535kr)", " (510kr)", " (220kr)"]
    end

    @ticketOpt = [["", ""], ["", ""],["", ""],["", ""]]

    for i in 0..3
      @ticketOpt[i][0] = @ticketText[i] + @ticketCost[i]
      @ticketOpt[i][1] = i
    end

  end

  def create
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
    response = database.update_orchestra(params[:id], orchestra_params)
    if response.success?
      flash[:success] = 'Orkester uppdaterad'
    else
      flash[:error] = 'Kunde inte uppdatera orkester'
    end

    redirect_to action: :show, id: params[:id]
  end

  def show
    @orchestra = database.show_orchestra params[:id]
    unless @orchestra.success?
      flash[:error] = 'Kunde inte hitta orkester'
      redirect_to '/'
    end
  end

  def reset_code
    response = database.update_orchestra(params[:id], {item: {code: 'reset'}})
    if response.success?
      flash[:success] = 'Kod uppdaterad'
    else
      flash[:error] = 'Kunde inte skapa ny kod'
    end

    redirect_to action: :show, id: params[:id]
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

end
