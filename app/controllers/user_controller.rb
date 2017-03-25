class UserController < NavigationController
  def index
    return if require_login!
  end

  def register
    if request.post?
      response = database.register(
          params[:display_name],
          params[:email],
          params[:password],
          params[:password_confirmation],
          account_activation_url
      )

      if response.success?
        flash[:success] = 'Ett mail har skickats till din e-postadress'
        redirect_to login_url
      else
        flash[:error] = response.friendly_error
        redirect_to action: :login, anchor: 'register-card', only_path: true
      end
    end
  end

  def login
    if params.key? 'account_confirmation_success'
      flash[:success] = 'Konto aktiverat'
      redirect_to login_url
    end

    if request.post?
      response = database.login(
          params[:email],
          params[:password]
      )

      if response.success?
        store_token_from_response response

        if params[:redirect_url]
          redirect_to params[:redirect_url]
        else
          redirect_to root_url
        end
      else
        flash.now[:error] = response.friendly_error
      end
    end
  end

  def request_password_reset
    if request.post?
      response = database.request_password_reset(params[:email], reset_url)
      if response.success?
        flash[:success] = 'Ett mail har skickats till adressen du angav'
        redirect_to login_url
      else
        flash.now[:error] = response.friendly_error
      end
    end
  end

  def reset_password
    @invalid = temporary_user.nil?
    if request.post? and not @invalid
      response = temporary_database.reset_password(params[:password], params[:password_confirmation])
      if response.success?
        flash[:success] = 'Lösenord återställt'
        redirect_to login_url
      else
        flash.now[:error] = response.friendly_error
      end
    end
  end

  def login_liu_id
    redirect_to liu_login_url
  end

  def verify_liu_id
    store_token

    if params[:redirect_url]
      redirect_to params[:redirect_url]
    else
      redirect_to profile_url
    end
  end

  def logout
    database.logout
    delete_token

    redirect_to root_url
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
    url_for controller: 'user', action: 'verify_liu_id', host: request.host, redirect_url: params[:redirect_url]
  end

  def account_activation_url
    url_for controller: 'user', action: 'login', host: request.host
  end
end
