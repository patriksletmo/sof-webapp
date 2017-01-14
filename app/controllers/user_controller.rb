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

  private

  def login_params
    if params.has_key?(:user_login)
      params.require(:user_login).permit(:email, :password)
    end
  end
end
