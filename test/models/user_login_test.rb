require 'test_helper'

class UserLoginTest < ActiveSupport::TestCase
  test 'should not be savable' do
    login = UserLogin.new
    login.email = 'foo@bar.io'
    login.password = 'hunter2'

    saved = login.save
    assert !saved
  end
end
