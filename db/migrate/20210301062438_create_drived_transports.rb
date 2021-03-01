class CreateDrivedTransports < ActiveRecord::Migration[6.1]
  def change
    create_table :drived_transports do |t|
      t.integer :person_id, index: true
      t.integer :transport_id, index: true

      t.timestamps
    end
  end
end
