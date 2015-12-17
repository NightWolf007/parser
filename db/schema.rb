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

ActiveRecord::Schema.define(version: 20151216194920) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", id: false, force: :cascade do |t|
    t.string  "id",                                 null: false
    t.integer "partner_id",                         null: false
    t.boolean "available_in_store", default: false, null: false
    t.string  "partner_item_id",                    null: false
    t.string  "title"
  end

  add_index "items", ["id"], name: "index_items_on_id", unique: true, using: :btree
  add_index "items", ["partner_id"], name: "index_items_on_partner_id", using: :btree

  create_table "partners", force: :cascade do |t|
    t.string   "xml_url",    null: false
    t.string   "xml_type",   null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
