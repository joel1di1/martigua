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

ActiveRecord::Schema.define(version: 20140216163255) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "availabilities", force: true do |t|
    t.integer  "user_id",                      null: false
    t.integer  "match_id",                     null: false
    t.boolean  "availability", default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "availabilities", ["match_id"], name: "index_availabilities_on_match_id", using: :btree
  add_index "availabilities", ["user_id", "match_id"], name: "index_availabilities_on_user_id_and_match_id", unique: true, using: :btree
  add_index "availabilities", ["user_id"], name: "index_availabilities_on_user_id", using: :btree

  create_table "championships", force: true do |t|
    t.string   "name"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clubs", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "commitments", force: true do |t|
    t.integer  "team_id",         null: false
    t.integer  "championship_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commitments", ["championship_id"], name: "index_commitments_on_championship_id", using: :btree
  add_index "commitments", ["team_id"], name: "index_commitments_on_team_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "locations", force: true do |t|
    t.string   "name",       null: false
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "match_days", force: true do |t|
    t.integer  "num",        null: false
    t.date     "start_date", null: false
    t.date     "end_date",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "match_days", ["start_date"], name: "index_match_days_on_start_date", using: :btree

  create_table "matches", force: true do |t|
    t.integer  "championship_id", null: false
    t.integer  "local_team_id",   null: false
    t.integer  "visitor_team_id", null: false
    t.datetime "starting_time"
    t.integer  "local_score"
    t.integer  "visitor_score"
    t.string   "official_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
    t.integer  "match_day_id"
  end

  add_index "matches", ["championship_id"], name: "index_matches_on_championship_id", using: :btree
  add_index "matches", ["location_id"], name: "index_matches_on_location_id", using: :btree
  add_index "matches", ["match_day_id"], name: "index_matches_on_match_day_id", using: :btree

  create_table "score_events", force: true do |t|
    t.integer  "user_id"
    t.string   "label"
    t.integer  "value"
    t.integer  "training_presence_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "score_events", ["training_presence_id"], name: "index_score_events_on_training_presence_id", using: :btree
  add_index "score_events", ["user_id"], name: "index_score_events_on_user_id", using: :btree

  create_table "selections", force: true do |t|
    t.integer  "match_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "selections", ["match_id"], name: "index_selections_on_match_id", using: :btree

  create_table "selections_users", id: false, force: true do |t|
    t.integer "user_id",      null: false
    t.integer "selection_id", null: false
  end

  create_table "teams", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "club_id"
  end

  add_index "teams", ["club_id"], name: "index_teams_on_club_id", using: :btree

  create_table "training_availabilities", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "training_id", null: false
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "training_availabilities", ["training_id"], name: "index_training_availabilities_on_training_id", using: :btree
  add_index "training_availabilities", ["user_id"], name: "index_training_availabilities_on_user_id", using: :btree

  create_table "training_presences", force: true do |t|
    t.integer  "training_id"
    t.integer  "user_id"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "training_presences", ["training_id"], name: "index_training_presences_on_training_id", using: :btree
  add_index "training_presences", ["user_id"], name: "index_training_presences_on_user_id", using: :btree

  create_table "trainings", force: true do |t|
    t.datetime "date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "location_id"
    t.boolean  "canceled",           default: false, null: false
    t.text     "cancelation_reason"
  end

  add_index "trainings", ["location_id"], name: "index_trainings_on_location_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "cotisation",             default: false, null: false
    t.boolean  "certificat_medical",     default: false, null: false
    t.boolean  "active",                 default: true,  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "nickname"
    t.string   "phone"
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token",   default: "",    null: false
    t.boolean  "is_coach",               default: false, null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
