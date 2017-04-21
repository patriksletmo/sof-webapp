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

  private

  def user_params
    {
        user: {
          display_name: params[:display_name],
          admin_permissions: permission_params
        }
    }
  end

  def permission_params
    permissions = 0
    unless params[:admin_permissions].nil?
      params[:admin_permissions].each do |key, value|
        permissions |= 1 << key.to_i
      end
    end

    permissions
  end
end
