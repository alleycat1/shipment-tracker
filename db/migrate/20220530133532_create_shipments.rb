class CreateShipments < ActiveRecord::Migration[6.1]
  def change
    create_table :shipments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.date :start_date
      t.date :expected_arrival_date
      t.integer :transport_type
      t.string :starting_location
      t.string :destination_location
      t.integer :qr_code_type

      t.timestamps
    end
  end
end
