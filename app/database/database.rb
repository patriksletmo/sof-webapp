class Database
  include HTTParty
  base_uri Rails.configuration.database_api_url

  def initialize(token)
    @token = token
  end

  def login(user_login)
    options = { :body => {
        :email => user_login.email,
        :password => user_login.password
    }}
    post('/api/v1/auth/sign_in', options)
  end

  def logout
    delete('/api/v1/auth/sign_out', authenticated_options)
  end

  def current_user
    get('/api/v1/user', authenticated_options)
  end

  private

  def get(*args)
    begin
      self.class.get(*args)
    rescue
      FailedResponse.new
    end
  end

  def post(*args)
    begin
      self.class.post(*args)
    rescue
      FailedResponse.new
    end
  end

  def delete(*args)
    begin
      self.class.delete(*args)
    rescue
      FailedResponse.new
    end
  end

  def authenticated_options
    {
        :headers => {
          'access-token': @token.auth_token,
          'token-type':   'Bearer',
          'client':       @token.client_id,
          'expiry':       @token.expiry,
          'uid':          @token.uid
        }
    }
  end
end
