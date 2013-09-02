class AddLatitudeAndLongitudeToStation < ActiveRecord::Migration
  def change
    add_column :stations, :latitude, :float
    add_column :stations, :longitude, :float
  end
end
