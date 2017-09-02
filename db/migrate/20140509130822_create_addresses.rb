class CreateAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.text  :street
      t.integer :number_odd_from
      t.integer :number_odd_to
      t.integer :number_even_from
      t.integer :number_even_to
      t.integer :district_nr
      t.string :district_name
      t.integer :zip
      t.integer :vote_district_id
      t.integer :local_election_district_id
      t.integer :landtag_election_district_id
      t.integer :bundestag_election_district_id
      t.timestamps
    end
  end
end
