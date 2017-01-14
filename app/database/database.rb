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

  private

  def post(*args)
    begin
      self.class.post(*args)
    rescue
      FailedResponse.new
    end
  end
end
