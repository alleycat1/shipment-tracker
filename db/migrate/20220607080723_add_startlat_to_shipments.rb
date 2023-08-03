class AddStartlatToShipments < ActiveRecord::Migration[6.1]
  def change
    add_column :shipments, :start_lat, :string
    add_column :shipments, :start_lon, :string
    add_column :shipments, :destination_lat, :string
    add_column :shipments, :destination_lon, :string
  end
end
