class AddPlanetFkToPeople < ActiveRecord::Migration[6.1]
  def change
    add_reference :people, :planet, index: true
  end
end
