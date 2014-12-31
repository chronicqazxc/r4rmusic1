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

ActiveRecord::Schema.define(version: 20141231024921) do

  create_table "composers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  create_table "editions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.integer  "year"
    t.float    "price"
    t.integer  "publisher_id"
    t.string   "title"
  end

  add_index "editions", ["publisher_id"], name: "index_editions_on_publisher_id"

  create_table "editions_works", id: false, force: true do |t|
    t.integer "edition_id"
    t.integer "work_id"
  end

  create_table "instruments", force: true do |t|
    t.string   "name"
    t.string   "family"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instruments_works", id: false, force: true do |t|
    t.integer "instrument_id"
    t.integer "work_id"
  end

  create_table "publishers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "city"
    t.string   "country"
  end

  create_table "works", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.integer  "composer_id"
    t.integer  "year"
    t.string   "kee"
    t.string   "opus"
  end

  add_index "works", ["composer_id"], name: "index_works_on_composer_id"

end
