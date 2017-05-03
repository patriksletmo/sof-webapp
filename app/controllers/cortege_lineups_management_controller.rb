class CortegeLineupsManagementController < NavigationController

  def index
    return if require_login!
    @cortege_lineups = database.all_corteges_lineup

    unless @cortege_lineups.success?
      flash[:error] = 'Kunde inte hämta lineup'
      @cortege_lineups={}
    end
    @cortege_lineups = @cortege_lineups.sort_by {|t| t["order"]}
  end

  def show
    return if require_login!
    @cortege_lineup = database.show_cortege_lineup(params[:id])
    unless @cortege_lineup.success?
      flash[:error] = 'Kunde inte hitta lineup'
      redirect_to action: :index
    end
  end

  def new
    return if require_login!
    @cortege_lineup={}

  end

  def edit
    return if require_login!
    @cortege_lineup={}
  end

  def create
    return if require_login!
    response = database.create_cortege_lineup(params.to_unsafe_h)
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
    response = database.update_cortege_lineup(params[:id], item_params)
    if response.success?
      flash[:success] = 'lineup uppdaterad'
      redirect_to action: :index
    else
      flash[:error] = 'Kunde inte uppdatera lineup'
      redirect_to action: :index
    end
  end

  def delete
    return if require_login!
    response = database.delete_cortege_lineup(params[:id])
    if response.success?
      flash[:success] = 'lineup borttagen'
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
