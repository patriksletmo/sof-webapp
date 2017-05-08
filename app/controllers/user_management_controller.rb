class UserManagementController < NavigationController
  def index
    return if require_login!

    if params['response']
      @users = []
      params['response'].each do |user|
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
    data = JSON.parse(response.body)
    if data.is_a? Array
      if params[:origin_controller] == 'item_collect'
        redirect_to controller: :item_collect, action: :index, response: data
      else
        redirect_to action: :index, response: data
      end
    else
      flash[:error] = data['message']
      redirect_back fallback_location: root_url
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
          usergroup: group_params,
          rebate_balance: params[:rebate_balance]
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
