class UserManagementController < NavigationController
  def index
    return if require_login!

    @users = database.all_users
    unless @users.success?
      redirect_to '/'
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
          permissions: permission_params
        }
    }
  end

  def permission_params
    permissions = 0
    unless params[:permission].nil?
      params[:permission].each do |key, value|
        permissions |= 1 << key.to_i
      end
    end

    permissions
  end
end
