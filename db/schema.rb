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

ActiveRecord::Schema.define(version: 20140710190753) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "languages", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repo_languages", force: true do |t|
    t.integer  "repo_id",         null: false
    t.integer  "language_id",     null: false
    t.integer  "amount_in_bytes"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repos", force: true do |t|
    t.integer  "user_id",                           null: false
    t.string   "full_name",                         null: false
    t.string   "name",                              null: false
    t.string   "html_url",                          null: false
    t.boolean  "profile_visibility", default: true
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "users", force: true do |t|
    t.string   "provider",                        null: false
    t.string   "uid",                             null: false
    t.string   "username",                        null: false
    t.string   "email",                           null: false
    t.string   "avatar_url",                      null: false
    t.string   "access_token",                    null: false
    t.boolean  "profile_created", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name",                       null: false
  end

  add_index "users", ["uid", "username"], name: "index_users_on_uid_and_username", unique: true, using: :btree

end
