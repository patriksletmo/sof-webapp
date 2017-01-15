module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    helper_method :current_user
  end

  def token
    AccessToken.new(
      cookies[:auth_token],
      cookies[:client_id],
      cookies[:expiry],
      cookies[:uid]
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

  def delete_token
    cookies.delete :auth_token
    cookies.delete :client_id
    cookies.delete :expiry
    cookies.delete :uid
  end

  def database
    @database ||= Database.new(token)
  end

  def current_user
    if has_token?
      @current_user = User.from_response(database.current_user) unless instance_variable_defined? :@current_user
      @current_user
    end
  end
end