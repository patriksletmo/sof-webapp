class AccessToken
  attr_reader :auth_token, :client_id, :expiry, :uid

  def initialize(auth_token, client_id, expiry, uid)
    @auth_token = auth_token
    @client_id = client_id
    @expiry = expiry
    @uid = uid
  end
end