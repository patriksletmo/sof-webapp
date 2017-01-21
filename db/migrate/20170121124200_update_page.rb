class UpdatePage < ActiveRecord::Migration[5.0]
  def change
    change_table :pages do |t|
      t.string :category
      t.string :page
      t.string :header
      t.text :content
      t.boolean :show_in_menu

    end
  end
end
