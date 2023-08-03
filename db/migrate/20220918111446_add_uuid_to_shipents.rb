class AddUuidToShipents < ActiveRecord::Migration[6.1]
  def change
    enable_extension 'pgcrypto' unless extensions.include?('pgcrypto')
    add_column :shipments, :exid, :uuid, default: "gen_random_uuid()", unique: true, null: false
    add_index :shipments, :exid
  end
end
