class AccessToken
  attr_reader :auth_token, :client_id, :expiry, :uid

  def initialize(auth_token, client_id, expiry, uid)
    @auth_token = auth_token
    @client_id = client_id
    @expiry = expiry
    @uid = uid
  end

  def headers
    unless @auth_token.nil?
      {
          'access-token': auth_token,
          'token-type': 'Bearer',
          'client': client_id,
          'expiry': expiry,
          'uid': uid
      }
    end
  end

  def self.dummy
    self.new(nil, nil, nil, nil)
  end
end