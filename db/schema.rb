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

ActiveRecord::Schema.define(version: 20150313111449) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "baskets", force: true do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order_id"
  end

  add_index "baskets", ["order_id"], name: "index_baskets_on_order_id", using: :btree

  create_table "events", force: true do |t|
    t.string   "name"
    t.date     "takes_place_on"
    t.string   "location"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "line_items", force: true do |t|
    t.integer  "product_id"
    t.integer  "basket_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "quantity",   default: 1
    t.integer  "order_id"
  end

  create_table "orders", force: true do |t|
    t.text     "name"
    t.text     "address"
    t.text     "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "viewed",     default: false, null: false
  end

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "slug"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "price_pennies",      default: 0,     null: false
    t.string   "price_currency",     default: "GBP", null: false
  end

  add_index "products", ["slug"], name: "index_products_on_slug", using: :btree

  create_table "suppliers", force: true do |t|
    t.string   "address"
    t.string   "name"
    t.string   "telephone_number"
    t.string   "website"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.decimal  "lat",              precision: 15, scale: 10
    t.decimal  "lng",              precision: 15, scale: 10
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "encrypted_password"
    t.string   "salt"
  end

end
