class CreatePalletScans < ActiveRecord::Migration[6.1]
  def change
    create_table :pallet_scans do |t|
      t.references :pallet, null: false, foreign_key: true
      t.string :location
      t.boolean :sticker_destroyed
      t.datetime :date
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
