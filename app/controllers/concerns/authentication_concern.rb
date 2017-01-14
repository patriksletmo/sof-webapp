module AuthenticationConcern
  extend ActiveSupport::Concern

  included do
    helper_method :token, :database
  end

  def token
    'TEST_TOKEN'
  end

  def database
    Database.new(token)
  end
end