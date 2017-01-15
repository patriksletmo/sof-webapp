class UserController < ApplicationController
  def index
  end

  def login
    @credentials = UserLogin.new(login_params)

    if request.post?
      response = database.login @credentials
      if response.success?
        redirect_to profile_url
      else
        flash[:error] = 'Kunde inte logga in'
      end
    end
  end

  def login_liu_id
    redirect_to liu_login_url
  end

  def verify_liu_id
    store_token
    redirect_to profile_url
  end

  def logout
    database.logout
    delete_token

    redirect_to profile_url
  end

  private

  def login_params
    if params.has_key?(:user_login)
      params.require(:user_login).permit(:email, :password)
    end
  end

  def liu_login_url
    Rails.configuration.database_api_url + '/api/v1/auth/cas?auth_origin_url=' + verify_liu_login_url
  end

  def verify_liu_login_url
    url_for controller: 'user', action: 'verify_liu_id', host: request.host
  end
end
