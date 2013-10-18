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

ActiveRecord::Schema.define(version: 20131017235434) do

  create_table "contact_preferences", force: true do |t|
    t.integer  "customer_id",         null: false
    t.integer  "contact_template_id", null: false
    t.boolean  "is_allowed",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_templates", force: true do |t|
    t.integer "organization_id", null: false
  end

  create_table "customer_contact_events", force: true do |t|
    t.integer  "customer_id",         null: false
    t.string   "type",                null: false
    t.integer  "contact_template_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "customers", force: true do |t|
    t.integer  "organization_id", null: false
    t.string   "email"
    t.string   "mobile_number"
    t.string   "org_id",          null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_lines", force: true do |t|
    t.integer "order_id",           null: false
    t.integer "quantity",           null: false
    t.float   "price",              null: false
    t.float   "tax_rate"
    t.float   "additional_charges"
  end

  create_table "orders", force: true do |t|
    t.string   "org_id",          null: false
    t.datetime "org_created_at",  null: false
    t.float    "subtotal",        null: false
    t.float    "total",           null: false
    t.integer  "organization_id", null: false
    t.integer  "product_id",      null: false
    t.integer  "customer_id",     null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "organizations", force: true do |t|
    t.string   "name",          null: false
    t.integer  "admin_user_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "org_id",          null: false
    t.string   "name"
    t.datetime "org_created_at",  null: false
    t.integer  "organization_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_organizations", force: true do |t|
    t.string   "user_id",         null: false
    t.integer  "organization_id", null: false
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
