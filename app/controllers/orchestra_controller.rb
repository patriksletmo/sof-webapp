class OrchestraController < NavigationController

  def index

  end

  def register
    @isLintek = true

    @text = ["Ingen biljett", "Torsdag (11/5) - Söndag (14/5)", "Fredag (12/5) - Söndag (14/5)", "Lördag (13/5) - Söndag (15/5)"]
    if @isLintek
        @cost = [" (0kr)", " (435kr)", " (410kr)", " (190kr)"]
    else
        @cost = [" (0kr)", " (535kr)", " (510kr)", " (220kr)"]
    end

    @opt = [["", ""], ["", ""],["", ""],["", ""]]

    for i in 0..3
      @opt[i][0] = @text[i] + @cost[i]
      @opt[i][1] = i
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

  def show
    @orchestra = database.show_orchestra params[:id]
    unless @orchestra.success?
      flash[:error] = 'Kunde inte hitta orkester'
      redirect_to '/'
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

end
