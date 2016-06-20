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

ActiveRecord::Schema.define(version: 20160620045024) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "athletes", force: :cascade do |t|
    t.jsonb    "name",       default: {}, null: false
    t.string   "photo"
    t.jsonb    "info",       default: {}
    t.integer  "country_id",              null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "athletes", ["country_id"], name: "index_athletes_on_country_id", using: :btree

  create_table "authentications", force: :cascade do |t|
    t.jsonb    "info"
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "authentications", ["user_id"], name: "index_authentications_on_user_id", using: :btree

  create_table "contest_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id",   null: false
    t.integer "descendant_id", null: false
    t.integer "generations",   null: false
  end

  add_index "contest_hierarchies", ["ancestor_id", "descendant_id", "generations"], name: "contest_anc_desc_idx", unique: true, using: :btree
  add_index "contest_hierarchies", ["descendant_id"], name: "contest_desc_idx", using: :btree

  create_table "contests", force: :cascade do |t|
    t.jsonb    "name",          default: {}
    t.datetime "start_at"
    t.datetime "published_at"
    t.integer  "parent_id"
    t.integer  "sort_order"
    t.integer  "discipline_id",              null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "contests", ["discipline_id"], name: "index_contests_on_discipline_id", using: :btree
  add_index "contests", ["parent_id"], name: "index_contests_on_parent_id", using: :btree

  create_table "countries", force: :cascade do |t|
    t.jsonb    "name",         default: {}, null: false
    t.string   "flag"
    t.jsonb    "info",         default: {}
    t.integer  "gold_count",   default: 0,  null: false
    t.integer  "silver_count", default: 0,  null: false
    t.integer  "bronze_count", default: 0,  null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "disciplines", force: :cascade do |t|
    t.jsonb    "name",       default: {},    null: false
    t.boolean  "finished",   default: false, null: false
    t.integer  "sport_id",                   null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "disciplines", ["sport_id"], name: "index_disciplines_on_sport_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.date     "start_date",               null: false
    t.date     "end_date",                 null: false
    t.jsonb    "info",        default: {}
    t.integer  "location_id",              null: false
    t.integer  "sport_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "events", ["location_id"], name: "index_events_on_location_id", using: :btree
  add_index "events", ["sport_id"], name: "index_events_on_sport_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.jsonb    "name",       default: {},    null: false
    t.jsonb    "address",    default: {}
    t.jsonb    "info",       default: {}
    t.string   "photo"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "sport",      default: false, null: false
  end

  create_table "participations", force: :cascade do |t|
    t.string   "score"
    t.integer  "rank"
    t.integer  "team_id",    null: false
    t.integer  "contest_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "participations", ["contest_id"], name: "index_participations_on_contest_id", using: :btree
  add_index "participations", ["team_id", "contest_id"], name: "index_participations_on_team_id_and_contest_id", unique: true, using: :btree
  add_index "participations", ["team_id"], name: "index_participations_on_team_id", using: :btree

  create_table "sports", force: :cascade do |t|
    t.jsonb    "name",        default: {}, null: false
    t.string   "icon"
    t.string   "photo_small"
    t.string   "photo"
    t.jsonb    "info",        default: {}
    t.integer  "format",      default: 0,  null: false
    t.integer  "location_id",              null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "sports", ["location_id"], name: "index_sports_on_location_id", using: :btree

  create_table "team_memberships", force: :cascade do |t|
    t.integer "athlete_id", null: false
    t.integer "team_id",    null: false
  end

  add_index "team_memberships", ["athlete_id", "team_id"], name: "index_team_memberships_on_athlete_id_and_team_id", unique: true, using: :btree
  add_index "team_memberships", ["athlete_id"], name: "index_team_memberships_on_athlete_id", using: :btree
  add_index "team_memberships", ["team_id"], name: "index_team_memberships_on_team_id", using: :btree

  create_table "teams", force: :cascade do |t|
    t.jsonb    "name",          default: {}
    t.integer  "rank"
    t.integer  "discipline_id",              null: false
    t.integer  "country_id",                 null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "teams", ["country_id"], name: "index_teams_on_country_id", using: :btree
  add_index "teams", ["discipline_id", "country_id"], name: "index_teams_on_discipline_id_and_country_id", using: :btree
  add_index "teams", ["discipline_id"], name: "index_teams_on_discipline_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",            null: false
    t.string   "crypted_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "athletes", "countries"
  add_foreign_key "authentications", "users"
  add_foreign_key "contests", "contests", column: "parent_id"
  add_foreign_key "contests", "disciplines"
  add_foreign_key "disciplines", "sports"
  add_foreign_key "events", "locations"
  add_foreign_key "events", "sports"
  add_foreign_key "participations", "contests"
  add_foreign_key "participations", "teams"
  add_foreign_key "sports", "locations"
  add_foreign_key "team_memberships", "athletes"
  add_foreign_key "team_memberships", "teams"
  add_foreign_key "teams", "countries"
  add_foreign_key "teams", "disciplines"
end
