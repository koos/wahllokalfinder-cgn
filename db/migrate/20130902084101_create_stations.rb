class CreateStations < ActiveRecord::Migration[5.1]
  def change
    create_table :stations do |t|
      t.integer :vote_district_id
      t.string :name
      t.string :address
      t.boolean :barrier_free
      t.string :district
      t.string :zip
      t.float :koor_x
      t.float :koor_y
      t.string :vote_district
      t.integer :local_election_district_id
      t.integer :landtag_election_district_id
      t.integer :bundestag_election_district_id

      t.timestamps
    end
  end
end
