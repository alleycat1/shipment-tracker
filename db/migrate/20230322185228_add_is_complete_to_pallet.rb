class AddIsCompleteToPallet < ActiveRecord::Migration[6.1]
  def change
    add_column :pallets, :is_complete, :boolean, default: false
  end
end
