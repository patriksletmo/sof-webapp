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

    @cortege_members = database.show_cortege_memberships(params[:id])
    unless @cortege_members.success?
      flash.now[:error] = 'Kunde inte hitta kårtegedeltarna'
    end
  end

  def update
    return if require_login!

    response = database.update_cortege(params[:id], item_params)
    if response.success?
      flash[:success] = 'Kårtegeanmälan uppdaterad'
      redirect_to action: :show, id: response['id']
    else
      flash[:error] = 'Kunde inte uppdatera kårtegeanmälan'
      redirect_to action: :show, id: response['id']
    end
  end

  def delete
    return if require_login!

    response = database.delete_cortege(params[:id])
    if response.success?
      flash[:success] = 'Intresseanmälan borttagen'
    else
      flash[:error] = 'Kunde inte ta bort intresseanmälan'
    end

    redirect_to action: :interest
  end

  def add_member
    return if require_login!

    response = database.create_cortege_membership(add_membership_params)
    if response.success?
      flash[:success] = 'Medlemmen tillagd'
      redirect_to action: :show, id: params['id']
    else
      flash[:error] = 'Något gick fel, medlemmen ej tillagd'
      redirect_to action: :show, id: params['id']
    end

  end

  def remove_member
    return if require_login!

    response = database.delete_cortege_membership(params[:membership_id])
    if response.success?
      flash[:success] = 'Medlemen bortagen'
      redirect_to action: :show, id: params['id']
    else
      flash[:error] = 'Något gick fel, medlemmen ej bortagen'
      redirect_to action: :show, id: params['id']
    end
  end


  private

  def add_membership_params
    if params[:cortege]
      cortege_params = {
          :cortege_membership => {
              :cortege_id => params[:id]
          },
          :user => {
              :email => params[:email]
          }
      }
    else
      cortege_params = {
          :cortege_membership => {
              :case_cortege_id => params[:id]
          },
          :user => {
              :email => params[:email]
          }
      }
    end
    cortege_params
  end

  def item_params
    # Filtering is performed in db-app
    params.to_unsafe_h
  end
end
