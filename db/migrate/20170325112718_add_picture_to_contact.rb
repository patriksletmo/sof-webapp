class AddPictureToContact < ActiveRecord::Migration[5.0]
  def change
    change_table :contacts do |t|
      t.string :picture
    end
  end
end
