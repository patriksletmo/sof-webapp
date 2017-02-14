class CaseCortegeManagementController < NavigationController
  def index
    return if require_login!

    @corteges = database.all_case_corteges
    unless @corteges.success?
      render status: 403
    end
  end

  def show
    return if require_login!

    @cortege = database.show_case_cortege(params[:id])
    unless @cortege.success?
      flash[:error] = 'Kunde inte hitta kårtegeanmälan'
      redirect_to action: :index
    end
  end

  def update
    return if require_login!

    response = database.update_case_cortege(params[:id], item_params)
    if response.success?
      flash[:success] = 'Status uppdaterad'
      redirect_to action: :show, id: response['id']
    else
      flash[:error] = 'Kunde inte uppdatera status'
      redirect_to action: :show, id: response['id']
    end
  end

  private

  def item_params
    # Filtering is performed in db-app
    fields = params.to_unsafe_h
    fields[:item][:approved] = (fields[:item][:approved] == 'on')

    fields
  end
end
