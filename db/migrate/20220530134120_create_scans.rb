class CreateScans < ActiveRecord::Migration[6.1]
  def change
    create_table :scans do |t|
      t.references :shipment, null: false, foreign_key: true
      t.string :location
      t.boolean :sticker_destroyed

      t.timestamps
    end
  end
end
