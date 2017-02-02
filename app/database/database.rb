require 'ext/response'

class Database
  include HTTParty
  include Areas::AccountArea
  include Areas::MenuArea
  include Areas::OrchestraArea
  include Areas::PagesArea
  include Areas::UserArea

  base_uri Rails.configuration.database_api_url

  def initialize(token)
    @token = token
  end

  private

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

  def put(*args)
    begin
      self.class.put(*args)
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
end
