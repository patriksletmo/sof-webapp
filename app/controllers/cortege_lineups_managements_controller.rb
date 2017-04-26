class CortegeLineupsManagementsController < ApplicationController
  before_action :set_cortege_lineups_management, only: [:show, :edit, :update, :destroy]

  # GET /cortege_lineups_managements
  # GET /cortege_lineups_managements.json
  def index
    @cortege_lineups_managements = CortegeLineupsManagement.all
  end

  # GET /cortege_lineups_managements/1
  # GET /cortege_lineups_managements/1.json
  def show
    @cortege = database.show_cortege_lineup(params[:id])
    unless @cortege.success?
      flash[:error] = 'Kunde inte hitta casekårtegeanmälan'
      redirect_to action: :index
    end
  end

  # GET /cortege_lineups_managements/new
  def new
    @cortege_lineup={}

  end

  # GET /cortege_lineups_managements/1/edit
  def edit

  end

  # POST /cortege_lineups_managements
  # POST /cortege_lineups_managements.json
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

  # PATCH/PUT /cortege_lineups_managements/1
  # PATCH/PUT /cortege_lineups_managements/1.json
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

  # DELETE /cortege_lineups_managements/1
  # DELETE /cortege_lineups_managements/1.json
  def destroy
    response = database.delete_cortege_lineup(params[:id])
    if response.success?
      flash[:success] = 'cortegen borttagen'
    else
      flash[:error] = 'Kunde inte ta bort cortegen'
    end

    redirect_to action: :new
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
end
