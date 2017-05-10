class LineupsManagementController < NavigationController

  def index
    return if require_login!
    @lineups = database.all_lineups

    unless @lineups.success?
      flash.now[:error] = 'Kunde inte hämta lineup'
      @lineups={}
    end
    @lineups = @lineups.sort_by {|t| t["order"]}
  end

  def show
    return if require_login!
    @lineup = database.show_lineup(params[:id])
    unless @lineup.success?
      flash[:error] = 'Kunde inte hitta lineup'
      redirect_to action: :index
    end
  end

  def new
    return if require_login!
    @lineup={}

  end

  def create
    return if require_login!
    response = database.create_lineup(item_params)
    if response.success?
      flash[:success] = 'Lineup skapad'
      redirect_to action: :index
    else
      flash[:error] = 'Kunde inte skapa lineup'
      redirect_to action: :new
    end
  end

  def update
    return if require_login!
    response = database.update_lineup(params[:id], item_params)
    if response.success?
      flash[:success] = 'Lineup uppdaterad'
      redirect_to action: :index
    else
      flash[:error] = 'Kunde inte uppdatera lineup'
      redirect_to action: :index
    end
  end

  def delete
    return if require_login!
    response = database.delete_lineup(params[:id])
    if response.success?
      flash[:success] = 'Lineup borttagen'
    else
      flash[:error] = 'Kunde inte ta bort lineup'
    end
    redirect_to action: :index
  end

  private
    def item_params
      # Filtering is performed in db-app
      params.to_unsafe_h
    end
end
