class CreatePages < ActiveRecord::Migration[5.0]
  def change
    create_table :pages do |t|
      t.string :category
      t.string :page
      t.string :header
      t.text :content
      t.boolean :show_in_menu

      t.timestamps
    end
  end
end
