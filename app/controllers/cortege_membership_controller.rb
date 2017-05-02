class CortegeMembershipController < NavigationController
  def add_member
    return if require_login!

    response = database.create_cortege_membership(add_membership_params)
    if response.success?
      flash[:success] = response['message']
    else
      flash[:error] = response['message']
    end
    redirect_back(fallback_location: root_path)
  end

  def remove_member
    return if require_login!

    response = database.delete_cortege_membership(params[:membership_id])
    if response.success?
      flash[:success] = response['message']
    else
      flash[:error] = response['message']
    end
    redirect_back(fallback_location: root_path)
  end


  private

  def add_membership_params
    if params[:cortege].present?
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

end
