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

ActiveRecord::Schema.define(version: 20160313032935) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "check_ins", force: :cascade do |t|
    t.decimal  "latitude",   null: false
    t.decimal  "longitude",  null: false
    t.text     "comment"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "check_ins", ["user_id"], name: "index_check_ins_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username",    null: false
    t.string   "password",    null: false
    t.string   "real_name",   null: false
    t.integer  "birth_year",  null: false
    t.integer  "birth_month", null: false
    t.integer  "birth_day",   null: false
    t.text     "bio"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "visited_countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "year",       null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "visited_countries", ["user_id"], name: "index_visited_countries_on_user_id", using: :btree

  add_foreign_key "check_ins", "users"
  add_foreign_key "visited_countries", "users"
end
