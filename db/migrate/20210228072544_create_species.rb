class CreateSpecies < ActiveRecord::Migration[6.1]
  def change
    create_table :species do |t|
      t.string :name
      t.integer :height_avg

      t.timestamps
    end
  end
end
