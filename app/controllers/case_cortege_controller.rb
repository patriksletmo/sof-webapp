class CaseCortegeController < NavigationController
  def new
    return if require_login!

    @cortege = {}
  end

  def create
    return if require_login!

    response = database.create_case_cortege(item_params)
    if response.success?
      flash[:success] = 'Casekårtegeanmälan skapad'
      redirect_to action: :show, id: response['id']
    else
      flash[:error] = 'Kunde inte skapa casekårtegeanmälan'
      redirect_to action: :new
    end
  end

  def show
    return if require_login!

    @cortege = database.show_case_cortege(params[:id])
    unless @cortege.success?
      flash[:error] = 'Kunde inte hitta casekårtegeanmälan'
      redirect_to action: :index
    end

    @cortege_members = database.show_case_cortege_memberships(params[:id])
    unless @cortege_members.success?
      flash.now[:error] = 'Kunde inte hitta kårtegedeltarna'
    end
  end

  def update
    return if require_login!

    response = database.update_case_cortege(params[:id], item_params)
    if response.success?
      flash[:success] = 'Casekårtegeanmälan uppdaterad'
      redirect_to action: :show, id: response['id']
    else
      flash[:error] = 'Kunde inte uppdatera casekårtegeanmälan'
      redirect_to action: :show, id: response['id']
    end
  end

  def delete
    return if require_login!

    response = database.delete_case_cortege(params[:id])
    if response.success?
      flash[:success] = 'Intresseanmälan borttagen'
    else
      flash[:error] = 'Kunde inte ta bort intresseanmälan'
    end

    redirect_to action: :new
  end


  private

  def item_params
    # Filtering is performed in db-app
    params.to_unsafe_h
  end
end
