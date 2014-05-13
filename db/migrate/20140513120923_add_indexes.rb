class AddIndexes < ActiveRecord::Migration
  def change
    add_index :addresses, [ :street, :zip ]
    add_index :stations, :vote_district_id
  end
end
