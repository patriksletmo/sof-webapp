class UserLogin < ApplicationRecord
  before_save :disallow_save

  def disallow_save
    # UserLogin is an intermediate model containing a plain text password and should NOT be stored!
    throw :abort
  end
end
