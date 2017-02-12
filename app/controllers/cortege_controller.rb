class CortegeController < NavigationController
  def interest
    return if require_login!

    @cortege = {}
  end

  def create
    return if require_login!

    response = database.create_cortege(item_params)
    if response.success?
      flash[:success] = 'Kårtegeanmälan skapad'
      redirect_to action: :show, id: response['id']
    else
      flash[:error] = 'Kunde inte skapa kårtegeanmälan'
      redirect_to action: :interest
    end
  end

  def show
    return if require_login!

    @cortege = database.show_cortege(params[:id])
    unless @cortege.success?
      flash[:error] = 'Kunde inte hitta kårtegeanmälan'
      redirect_to action: :index
    end
  end

  private

  def item_params
    # Filtering is performed in db-app
    params.to_unsafe_h
  end
end
