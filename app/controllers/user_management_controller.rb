class UserManagementController < NavigationController
  def index
    @users = database.all_users
    unless @users.success?
      render status: 403
    end
  end

  def show
    @user = database.single_user params[:id]
    unless @user.success?
      render status: 404
    end
  end

  def update
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
          name: params[:name],
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
