require 'ext/response'

class Database
  include HTTParty
  include Areas::AccountArea
  include Areas::BaseProductArea
  include Areas::CartArea
  include Areas::CaseCortegeArea
  include Areas::CollectArea
  include Areas::CortegeArea
  include Areas::CortegeLineupArea
  include Areas::CortegeMembershipArea
  include Areas::FunkisArea
  include Areas::MenuArea
  include Areas::OrchestraArea
  include Areas::PagesArea
  include Areas::ProductArea
  include Areas::StoreArea
  include Areas::UserArea
  include Areas::UserInventoryArea


  base_uri Rails.configuration.database_api_url

  def initialize(token)
    @token = token
  end

  private

  def authenticated_options
    {headers: @token.headers}
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
    rescue Exception => e
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
