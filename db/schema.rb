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

ActiveRecord::Schema.define(version: 20150514115153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image_id"
  end

  create_table "people", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "github_account"
    t.string   "twitter_account"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "image_id"
  end

  add_index "people", ["user_id"], name: "index_people_on_user_id", using: :btree

  create_table "person_technologies", force: :cascade do |t|
    t.integer "person_id"
    t.integer "technology_id"
    t.integer "skill_rating",  default: 0, null: false
  end

  add_index "person_technologies", ["person_id"], name: "index_person_technologies_on_person_id", using: :btree
  add_index "person_technologies", ["technology_id"], name: "index_person_technologies_on_technology_id", using: :btree

  create_table "project_members", force: :cascade do |t|
    t.integer "project_id"
    t.integer "person_id"
    t.date    "period_start"
    t.date    "period_end"
    t.string  "function"
  end

  add_index "project_members", ["person_id"], name: "index_project_members_on_person_id", using: :btree
  add_index "project_members", ["project_id"], name: "index_project_members_on_project_id", using: :btree

  create_table "project_technologies", force: :cascade do |t|
    t.integer "project_id"
    t.integer "technology_id"
  end

  add_index "project_technologies", ["project_id"], name: "index_project_technologies_on_project_id", using: :btree
  add_index "project_technologies", ["technology_id"], name: "index_project_technologies_on_technology_id", using: :btree

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "scm_type"
    t.string   "scm_reference"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "image_id"
    t.integer  "client_id"
  end

  add_index "projects", ["client_id"], name: "index_projects_on_client_id", using: :btree

  create_table "technologies", force: :cascade do |t|
    t.string   "name"
    t.string   "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "image_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "people", "users"
  add_foreign_key "projects", "clients"
end
