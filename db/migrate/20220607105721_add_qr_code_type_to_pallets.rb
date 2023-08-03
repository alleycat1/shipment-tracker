class AddQrCodeTypeToPallets < ActiveRecord::Migration[6.1]
  def change
    add_column :pallets, :qr_code_type, :integer, default: 0
  end
end
