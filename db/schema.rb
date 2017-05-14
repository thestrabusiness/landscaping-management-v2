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

ActiveRecord::Schema.define(version: 20170508000442) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.integer  "client_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.integer  "position"
    t.boolean  "is_job_address?", default: true
    t.index ["client_id"], name: "index_addresses_on_client_id", using: :btree
  end

  create_table "clients", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.money    "balance",            scale: 2, default: "0.0"
    t.string   "email"
    t.string   "phone_number"
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.datetime "deleted_at"
    t.integer  "billing_address_id"
    t.integer  "old_id"
    t.index ["billing_address_id"], name: "index_clients_on_billing_address_id", using: :btree
    t.index ["id"], name: "index_clients_on_id", using: :btree
  end

  create_table "estimates", force: :cascade do |t|
    t.datetime "date"
    t.money    "total",      scale: 2
    t.string   "notes"
    t.integer  "address_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["address_id"], name: "index_estimates_on_address_id", using: :btree
  end

  create_table "estimates_items", force: :cascade do |t|
    t.string   "description"
    t.money    "price",       scale: 2
    t.integer  "quantity"
    t.integer  "estimate_id"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["estimate_id"], name: "index_estimates_items_on_estimate_id", using: :btree
  end

  create_table "invoice_items", force: :cascade do |t|
    t.integer  "invoice_id"
    t.string   "name"
    t.money    "price",      scale: 2
    t.integer  "quantity"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.index ["invoice_id"], name: "index_invoice_items_on_invoice_id", using: :btree
  end

  create_table "invoices", force: :cascade do |t|
    t.integer  "client_id"
    t.money    "total",              scale: 2, default: "0.0"
    t.datetime "job_date"
    t.string   "performed_by"
    t.string   "notes"
    t.string   "status",                       default: "PENDING"
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.datetime "deleted_at"
    t.integer  "billing_address_id"
    t.integer  "job_address_id"
    t.index ["billing_address_id"], name: "index_invoices_on_billing_address_id", using: :btree
    t.index ["client_id"], name: "index_invoices_on_client_id", using: :btree
    t.index ["job_address_id"], name: "index_invoices_on_job_address_id", using: :btree
  end

  create_table "payments", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "invoice_id"
    t.money    "amount",       scale: 2
    t.string   "payment_type"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.datetime "deleted_at"
    t.index ["client_id"], name: "index_payments_on_client_id", using: :btree
    t.index ["invoice_id"], name: "index_payments_on_invoice_id", using: :btree
  end

  create_table "service_prices", force: :cascade do |t|
    t.string   "name"
    t.money    "price",      scale: 2
    t.integer  "client_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "address_id"
    t.index ["address_id"], name: "index_service_prices_on_address_id", using: :btree
    t.index ["client_id"], name: "index_service_prices_on_client_id", using: :btree
  end

  create_table "services", force: :cascade do |t|
    t.string "name"
  end

end
