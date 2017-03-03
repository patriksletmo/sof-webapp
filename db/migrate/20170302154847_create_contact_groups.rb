class CreateContactGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :contact_groups do |t|
      t.string "group"
      t.string "title"
      t.timestamps
    end
  end
end
