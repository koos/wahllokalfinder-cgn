# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20130902100520) do

  create_table "stations", force: true do |t|
    t.integer  "vote_district_id"
    t.string   "name"
    t.string   "address"
    t.boolean  "barrier_free"
    t.string   "district"
    t.string   "zip"
    t.float    "koor_x"
    t.float    "koor_y"
    t.string   "vote_district"
    t.integer  "local_election_district_id"
    t.integer  "landtag_election_district_id"
    t.integer  "bundestag_election_district_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_address"
    t.float    "latitude"
    t.float    "longitude"
  end

end
