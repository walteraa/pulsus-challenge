class CreatePeople < ActiveRecord::Migration[6.1]
  def change
    create_table :people do |t|
      t.string :name
      t.string :birthday_year
      t.integer :height
      t.integer :mass

      t.timestamps
    end
  end
end
