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
    @cortege = database.show_cortege_lineup(params[:id])
    unless @cortege.success?
      flash[:error] = 'Kunde inte hitta casekårtegeanmälan'
      redirect_to action: :index
    end
  end

  # GET /cortege_lineups/new
  def new
    @cortege_lineup={}

  end

  # GET /cortege_lineups/1/edit
  def edit
  end

  # POST /cortege_lineups
  # POST /cortege_lineups.json
  def create
    return if require_login!
    response = database.create_cortege_lineup(params.to_unsafe_h)
    if response.success?
      flash[:success] = 'kårtegeanmälan skapad'
      redirect_to action: :index
    else
      flash[:error] = 'Kunde inte skapa kårtegeanmälan'
      redirect_to action: :new
    end
  end

  # PATCH/PUT /cortege_lineups/1
  # PATCH/PUT /cortege_lineups/1.json
  def update
    respond_to do |format|
      if @cortege_lineup.update(cortege_contribution_params)
        format.html { redirect_to @cortege_lineup, notice: 'Cortege contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @cortege_lineup }
      else
        format.html { render :edit }
        format.json { render json: @cortege_lineup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cortege_lineups/1
  # DELETE /cortege_lineups/1.json
  def delete
    response = database.delete_cortege_lineup(params[:id])
    if response.success?
      flash[:success] = 'cortegen borttagen'
    else
      flash[:error] = 'Kunde inte ta bort cortegen'
    end

    redirect_to action: :new
  end

  private

  def item_params
    # Filtering is performed in db-app
    params.to_unsafe_h
  end
end
