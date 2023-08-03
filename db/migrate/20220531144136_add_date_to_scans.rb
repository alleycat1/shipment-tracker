class AddDateToScans < ActiveRecord::Migration[6.1]
  def change
    add_column :scans, :date, :datetime
  end
end
