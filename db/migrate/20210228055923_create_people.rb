class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :name, null: false
      t.string :birthday_year, null: false
      t.integer :height, null: false
      t.integer :mass, null: false

      t.timestamps
    end
  end
end
