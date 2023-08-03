class AddStatusToShipment < ActiveRecord::Migration[6.1]
  def change
    add_column :shipments, :status, :integer, default: 0
  end
end
