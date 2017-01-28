class User < ApplicationRecord
  def self.from_response(response)
    if response.success?
      User.new(
        username: response['uid']
      )
    end
  end
end
