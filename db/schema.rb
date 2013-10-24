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

  create_table "customer_cohort_schemes", force: true do |t|
    t.string "name", null: false
  end

  create_table "customer_cohorts", force: true do |t|
    t.integer "customer_cohort_scheme_id", null: false
    t.integer "customer_id",               null: false
    t.integer "cohort_value_int"
    t.string  "cohort_value",              null: false
  end

  add_index "customer_cohorts", ["customer_id", "customer_cohort_scheme_id"], name: "customer_cohort_cust_id", unique: true, using: :btree

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
    t.datetime "org_created_at"
  end

  add_index "customers", ["org_created_at", "organization_id"], name: "index_customers_on_org_created_at_and_organization_id", using: :btree
  add_index "customers", ["org_id", "organization_id"], name: "index_customers_on_org_id_and_organization_id", unique: true, using: :btree
  add_index "customers", ["organization_id"], name: "index_customers_on_organization_id", using: :btree

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

  create_table "order_lines", force: true do |t|
    t.integer "order_id",           null: false
    t.integer "quantity",           null: false
    t.float   "price",              null: false
    t.float   "tax_rate"
    t.float   "additional_charges"
    t.integer "product_id",         null: false
  end

  add_index "order_lines", ["order_id", "product_id"], name: "index_order_lines_on_order_id_and_product_id", unique: true, using: :btree
  add_index "order_lines", ["order_id"], name: "index_order_lines_on_order_id", using: :btree
  add_index "order_lines", ["product_id", "order_id"], name: "index_order_lines_on_product_id_and_order_id", unique: true, using: :btree

  create_table "orders", force: true do |t|
    t.string   "org_id",                 null: false
    t.datetime "org_created_at",         null: false
    t.float    "subtotal",               null: false
    t.float    "total",                  null: false
    t.integer  "organization_id",        null: false
    t.integer  "customer_id",            null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "customer_age"
    t.integer  "next_previous_order_id"
    t.integer  "num_previous_purchases"
  end

  add_index "orders", ["customer_id"], name: "index_orders_on_customer_id", using: :btree
  add_index "orders", ["org_created_at", "organization_id"], name: "index_orders_on_org_created_at_and_organization_id", using: :btree
  add_index "orders", ["org_id", "organization_id"], name: "index_orders_on_org_id_and_organization_id", unique: true, using: :btree
  add_index "orders", ["organization_id"], name: "index_orders_on_organization_id", using: :btree

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

  add_index "products", ["org_id", "organization_id"], name: "index_products_on_org_id_and_organization_id", unique: true, using: :btree
  add_index "products", ["organization_id"], name: "index_products_on_organization_id", using: :btree

  create_table "purchase_sequences", force: true do |t|
    t.float   "net_score"
    t.float   "product1_score"
    t.float   "product2_score"
    t.integer "product_sequence_count"
    t.integer "product1_id"
    t.float   "product1_avg_customer_age"
    t.float   "product1_avg_num_prev_purchases"
    t.integer "product2_id"
    t.float   "product2_avg_customer_age"
    t.float   "product2_avg_num_prev_purchases"
  end

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
