class CreatePersonSpecies < ActiveRecord::Migration[6.1]
  def change
    create_table :person_species do |t|
      t.integer :person_id, index: true
      t.integer :specie_id, index: true

      t.timestamps
    end
  end
end
