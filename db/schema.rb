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

ActiveRecord::Schema.define(version: 20160415112302) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.string   "name",       null: false
    t.text     "info"
    t.integer  "team_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "athletes", ["team_id"], name: "index_athletes_on_team_id", using: :btree

  create_table "athletes_discipline_teams", id: false, force: :cascade do |t|
    t.integer "athlete_id",         null: false
    t.integer "discipline_team_id", null: false
  end

  add_index "athletes_discipline_teams", ["athlete_id", "discipline_team_id"], name: "index_athletes_discipline_teams", unique: true, using: :btree
  add_index "athletes_discipline_teams", ["athlete_id"], name: "index_athletes_discipline_teams_on_athlete_id", using: :btree
  add_index "athletes_discipline_teams", ["discipline_team_id"], name: "index_athletes_discipline_teams_on_discipline_team_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "discipline_teams", force: :cascade do |t|
    t.integer  "rank",          default: 9999, null: false
    t.integer  "discipline_id",                null: false
    t.integer  "team_id",                      null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "discipline_teams", ["discipline_id", "team_id"], name: "index_discipline_teams_on_discipline_id_and_team_id", unique: true, using: :btree
  add_index "discipline_teams", ["discipline_id"], name: "index_discipline_teams_on_discipline_id", using: :btree
  add_index "discipline_teams", ["team_id"], name: "index_discipline_teams_on_team_id", using: :btree

  create_table "disciplines", force: :cascade do |t|
    t.string   "name",                       null: false
    t.boolean  "finished",   default: false, null: false
    t.integer  "sport_id",                   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "disciplines", ["sport_id"], name: "index_disciplines_on_sport_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "name"
    t.datetime "start_at"
    t.datetime "published_at"
    t.string   "path"
    t.integer  "depth"
    t.integer  "position"
    t.integer  "parent_id"
    t.integer  "children_count"
    t.integer  "location_id",    null: false
    t.integer  "discipline_id",  null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "events", ["discipline_id"], name: "index_events_on_discipline_id", using: :btree
  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree
  add_index "events", ["parent_id"], name: "index_events_on_parent_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "name",       null: false
    t.text     "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.string   "score"
    t.boolean  "win",                default: false, null: false
    t.integer  "discipline_team_id",                 null: false
    t.integer  "event_id",                           null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "participations", ["discipline_team_id", "event_id"], name: "index_participations_on_discipline_team_id_and_event_id", unique: true, using: :btree
  add_index "participations", ["discipline_team_id"], name: "index_participations_on_discipline_team_id", using: :btree
  add_index "participations", ["event_id"], name: "index_participations_on_event_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "icon"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "teams", force: :cascade do |t|
    t.string   "name"
    t.integer  "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "teams", ["country_id"], name: "index_teams_on_country_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                        null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_me_token"
    t.datetime "remember_me_token_expires_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["remember_me_token"], name: "index_users_on_remember_me_token", using: :btree

  add_foreign_key "athletes", "teams"
  add_foreign_key "athletes_discipline_teams", "athletes"
  add_foreign_key "athletes_discipline_teams", "discipline_teams"
  add_foreign_key "discipline_teams", "disciplines"
  add_foreign_key "discipline_teams", "teams"
  add_foreign_key "disciplines", "sports"
  add_foreign_key "events", "disciplines"
  add_foreign_key "events", "events", column: "parent_id"
  add_foreign_key "events", "locations"
  add_foreign_key "participations", "discipline_teams"
  add_foreign_key "participations", "events"
  add_foreign_key "teams", "countries"
end
