class DropCortegeLinup < ActiveRecord::Migration[5.0]
  def change
    drop_table :cortege_contributions
  end
end
