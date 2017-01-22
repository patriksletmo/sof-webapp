class Database
  include HTTParty
  base_uri Rails.configuration.database_api_url

  def initialize(token)
    @token = token
  end

  def menu_items
    self.class.get('/api/v1/menu')
  end

end