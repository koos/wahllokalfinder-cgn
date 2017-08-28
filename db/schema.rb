# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170828180826) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.text "street"
    t.integer "number_odd_from"
    t.integer "number_odd_to"
    t.integer "number_even_from"
    t.integer "number_even_to"
    t.integer "district_nr"
    t.string "district_name"
    t.integer "zip"
    t.integer "vote_district_id"
    t.integer "local_election_district_id"
    t.integer "landtag_election_district_id"
    t.integer "bundestag_election_district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["street", "zip"], name: "index_addresses_on_street_and_zip"
  end

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.text "zip"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
  end

  create_table "stations", force: :cascade do |t|
    t.integer "vote_district_id"
    t.string "name"
    t.string "address"
    t.boolean "barrier_free"
    t.string "district"
    t.string "zip"
    t.float "koor_x"
    t.float "koor_y"
    t.string "vote_district"
    t.integer "local_election_district_id"
    t.integer "landtag_election_district_id"
    t.integer "bundestag_election_district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "full_address"
    t.float "latitude"
    t.float "longitude"
    t.string "note"
    t.integer "vote_letter_id"
    t.integer "wlk_eu"
    t.integer "wlk_gm"
    t.string "phone"
    t.index ["vote_district_id"], name: "index_stations_on_vote_district_id"
  end

end
