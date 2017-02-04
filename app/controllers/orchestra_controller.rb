class OrchestraController < NavigationController

  def index

  end

  def register

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
