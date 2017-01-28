class AddFieldsToUserLogin < ActiveRecord::Migration[5.0]
  def change
    add_column :user_logins, :email, :string
    add_column :user_logins, :password, :string
  end
end
