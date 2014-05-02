class AddNoteToStations < ActiveRecord::Migration
  def change
    add_column :stations, :note, :string
  end
end
