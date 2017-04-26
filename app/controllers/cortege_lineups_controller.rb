class CortegeLineupsController < NavigationController
  #before_action :set_cortege_contribution, only: [:show, :edit, :update, :destroy]

  # GET /cortege_lineups
  # GET /cortege_lineups.json
  def index
    @cortege = database.all_corteges_lineup()
    unless @cortege.success?
      flash[:error] = 'Kunde inte hämta kårtege'
      @cortege={}
    end
  end

  # GET /cortege_lineups/1
  # GET /cortege_lineups/1.json
  def show

  end

  # GET /cortege_lineups/new
  def new

  end

  # GET /cortege_lineups/1/edit
  def edit
  end

  # POST /cortege_lineups
  # POST /cortege_lineups.json
  def create
  end

  # PATCH/PUT /cortege_lineups/1
  # PATCH/PUT /cortege_lineups/1.json
  def update

  end

  # DELETE /cortege_lineups/1
  # DELETE /cortege_lineups/1.json
  def delete
  end

  private

  def item_params
    # Filtering is performed in db-app
    params.to_unsafe_h
  end
end
