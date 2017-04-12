class CortegeContributionsController < ApplicationController
  before_action :set_cortege_contribution, only: [:show, :edit, :update, :destroy]

  # GET /cortege_contributions
  # GET /cortege_contributions.json
  def index
    @cortege_contributions = CortegeContribution.all
  end

  # GET /cortege_contributions/1
  # GET /cortege_contributions/1.json
  def show
  end

  # GET /cortege_contributions/new
  def new
    @cortege_contribution = CortegeContribution.new
  end

  # GET /cortege_contributions/1/edit
  def edit
  end

  # POST /cortege_contributions
  # POST /cortege_contributions.json
  def create
    @cortege_contribution = CortegeContribution.new(cortege_contribution_params)

    respond_to do |format|
      if @cortege_contribution.save
        format.html { redirect_to @cortege_contribution, notice: 'Cortege contribution was successfully created.' }
        format.json { render :show, status: :created, location: @cortege_contribution }
      else
        format.html { render :new }
        format.json { render json: @cortege_contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cortege_contributions/1
  # PATCH/PUT /cortege_contributions/1.json
  def update
    respond_to do |format|
      if @cortege_contribution.update(cortege_contribution_params)
        format.html { redirect_to @cortege_contribution, notice: 'Cortege contribution was successfully updated.' }
        format.json { render :show, status: :ok, location: @cortege_contribution }
      else
        format.html { render :edit }
        format.json { render json: @cortege_contribution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cortege_contributions/1
  # DELETE /cortege_contributions/1.json
  def destroy
    @cortege_contribution.destroy
    respond_to do |format|
      format.html { redirect_to cortege_contributions_url, notice: 'Cortege contribution was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cortege_contribution
      @cortege_contribution = CortegeContribution.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cortege_contribution_params
      params.fetch(:cortege_contribution, {})
    end
end
