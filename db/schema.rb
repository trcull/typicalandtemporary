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

ActiveRecord::Schema.define(version: 20131023231447) do

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

  create_table "site_accounts", force: true do |t|
    t.string   "type",             default: "SiteAccount", null: false
    t.integer  "site_id",                                  null: false
    t.integer  "user_id",                                  null: false
    t.integer  "organization_id",                          null: false
    t.string   "name",                                     null: false
    t.string   "site_user_id"
    t.string   "encrypted_token"
    t.string   "encrypted_secret"
    t.string   "encrypted_field1"
    t.string   "encrypted_field2"
    t.string   "encrypted_field3"
    t.string   "encrypted_field4"
    t.string   "encrypted_field5"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "site_accounts", ["organization_id", "user_id"], name: "index_site_accounts_on_organization_id_and_user_id", using: :btree
  add_index "site_accounts", ["site_id"], name: "index_site_accounts_on_site_id", using: :btree

  create_table "sites", force: true do |t|
    t.string   "key",                       null: false
    t.string   "name",                      null: false
    t.boolean  "active",     default: true, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
