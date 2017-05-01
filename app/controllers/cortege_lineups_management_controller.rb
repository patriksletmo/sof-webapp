class CortegeLineupsManagementController < NavigationController

  # GET /cortege_lineups_management
  # GET /cortege_lineups_management.json
  def index
    return if require_login!
    @cortege_lineups = database.all_corteges_lineup

    unless @cortege_lineups.success?
      flash[:error] = 'Kunde inte hämta kårtege'
      @cortege_lineups={}
    end
    @cortege_lineups = @cortege_lineups.sort_by {|t| t["order"]}
  end

  # GET /cortege_lineups_management/1
  # GET /cortege_lineups_management/1.json
  def show
    return if require_login!
    @cortege_lineup = database.show_cortege_lineup(params[:id])
    unless @cortege_lineup.success?
      flash[:error] = 'Kunde inte hitta casekårtegeanmälan'
      redirect_to action: :index
    end
  end

  # GET /cortege_lineups_management/new
  def new
    return if require_login!
    @cortege_lineup={}

  end

  # GET /cortege_lineups_management/1/edit
  def edit
    return if require_login!
    @cortege_lineup={}
  end

  # POST /cortege_lineups_management
  # POST /cortege_lineups_management.json
  def create
    return if require_login!
    response = database.create_cortege_lineup(params.to_unsafe_h)
    if response.success?
      flash[:success] = 'kårtegelineup skapad'
      redirect_to action: :index
    else
      flash[:error] = 'Kunde inte skapa kårtegelineup'
      redirect_to action: :new
    end
  end

  # PATCH/PUT /cortege_lineups_management/1
  # PATCH/PUT /cortege_lineups_management/1.json
  def update
    return if require_login!
    response = database.update_cortege_lineup(params[:id], item_params)
    if response.success?
      flash[:success] = 'kårtegelineup uppdaterad'
      redirect_to action: :index
    else
      flash[:error] = 'Kunde inte uppdatera kårtegelineup'
      redirect_to action: :index
    end
  end

  # DELETE /cortege_lineups_management/1
  # DELETE /cortege_lineups_management/1.json
  def delete
    return if require_login!
    response = database.delete_cortege_lineup(params[:id])
    if response.success?
      flash[:success] = 'kårtegelineup borttagen'
    else
      flash[:error] = 'Kunde inte ta bort kårtegelineup'
    end

    redirect_to action: :index
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cortege_lineups_management
      @cortege_lineups_management = CortegeLineupsManagement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cortege_lineups_management_params
      params.fetch(:cortege_lineups_management, {})
    end

    def item_params
      # Filtering is performed in db-app
      params.to_unsafe_h
    end
end
