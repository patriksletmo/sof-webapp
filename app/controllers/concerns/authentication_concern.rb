module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_user, :temporary_user
  end

  def token
    AccessToken.new(
      cookies[:auth_token],
      cookies[:client_id],
      cookies[:expiry],
      cookies[:uid]
    )
  end

  def temporary_token
    AccessToken.new(
        params[:token],
        params[:client_id],
        params[:expiry],
        params[:uid]
    )
  end

  def has_token?
    not cookies[:auth_token].nil?
  end

  def store_token
    cookies.permanent[:auth_token] = request.GET[:auth_token]
    cookies.permanent[:client_id] = request.GET[:client_id]
    cookies.permanent[:expiry] = request.GET[:expiry]
    cookies.permanent[:uid] = request.GET[:uid]
  end

  def store_token_from_response(response)
    cookies.permanent[:auth_token] = response.headers['access-token']
    cookies.permanent[:client_id] = response.headers['client']
    cookies.permanent[:expiry] = response.headers['expiry']
    cookies.permanent[:uid] = response.headers['uid']
  end

  def delete_token
    cookies.delete :auth_token
    cookies.delete :client_id
    cookies.delete :expiry
    cookies.delete :uid
  end

  def database
    @database ||= Database.new(token)
  end

  def temporary_database
    @database ||= Database.new(temporary_token)
  end

  def current_user
    if has_token?
      @current_user = User.from_response(database.current_user) unless instance_variable_defined? :@current_user
      @current_user
    end
  end

  def temporary_user
    @temporary_user = User.from_response(temporary_database.current_user) unless instance_variable_defined? :@temporary_user
    @temporary_user
  end
end