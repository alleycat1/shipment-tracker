class CreatePallets < ActiveRecord::Migration[6.1]
  def change
    create_table :pallets do |t|
      t.references :user, null: false, foreign_key: true
      t.references :shipment, null: false, foreign_key: true
      t.string :content
      t.string :content_category

      t.timestamps
    end
  end
end
