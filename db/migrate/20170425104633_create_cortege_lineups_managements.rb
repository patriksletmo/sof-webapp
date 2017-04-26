class CreateCortegeLineupsManagements < ActiveRecord::Migration[5.0]
  def change
    create_table :cortege_lineups_managements do |t|

      t.timestamps
    end
  end
end
