class AddCoordinatesToScans < ActiveRecord::Migration[6.1]
  def change
    add_column :scans, :latitude, :float
    add_column :scans, :longitude, :float
  end
end
