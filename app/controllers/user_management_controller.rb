class UserManagementController < NavigationController
  def index
    return if require_login!

    if params[:id].present?
      @users = []

      params['id'].each do |user|
        user = database.single_user user['id']
        @users.append user
      end
    end
  end

  def show
    return if require_login!

    @user = database.single_user params[:id]
    unless @user.success?
      redirect_to '/'
    end
  end

  def update
    return if require_login!

    response = database.update_user(params[:id], user_params)
    if response.success?
      flash[:success] = 'Användare sparad'
    else
      flash[:error] = 'Kunde inte spara användare'
    end

    redirect_to action: :show
  end

  def search
    return if require_login!

    response = database.search_for_users params[:query]
    unless response.success?
      if response['message'].present?
        flash[:error] = response['message']
      else
        flash[:error] = 'Ett okänt fel uppstod'
      end
    end

    if params[:origin_controller] == 'item_collect'
      redirect_to controller: :item_collect, action: :index, ids: response
    else
      redirect_to action: :index, id: response
    end
  end

  def remove_funkis_application
    return if require_login!

    @user = database.single_user params[:id]
    response = database.delete_funkis_application(@user['funkis_application']['id'])
    if response.success?
      flash[:success] = 'Funkisanmälan borttagen'
    else
      flash[:error] = 'Kunde inte ta bort anmälan'
    end

    redirect_to action: :show
  end

  private

  def user_params
    {
        user: {
          display_name: params[:display_name],
          admin_permissions: permission_params,
          usergroup: group_params
        }
    }
  end

  def permission_params
    permissions = 0
    unless params[:admin_permission].nil?
      params[:admin_permission].each do |key, value|
        permissions |= 1 << key.to_i
      end
    end

    permissions
  end

  def group_params
    groups = 0
    unless params[:group].nil?
      params[:group].each do |key, value|
        groups |= 1 << key.to_i
      end
    end

    groups
  end
end
