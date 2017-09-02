class AddMissingAttributesToStations < ActiveRecord::Migration[5.1]
  def change
    add_column :stations, :vote_letter_id, :integer
    add_column :stations, :wlk_eu, :integer
    add_column :stations, :wlk_gm, :integer
  end
end
