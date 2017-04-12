class CreateCortegeContributions < ActiveRecord::Migration[5.0]
  def change
    create_table :cortege_contributions do |t|

      t.timestamps
    end
  end
end
