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

ActiveRecord::Schema.define(version: 20150201082558) do

  create_table "businesses", force: true do |t|
    t.string   "name"
    t.string   "image_url"
    t.string   "url"
    t.string   "mobile_url"
    t.string   "phone"
    t.string   "display_phone"
    t.string   "review_count"
    t.integer  "rating"
    t.string   "rating_img_url_large"
    t.string   "snippet_text"
    t.string   "address"
    t.string   "display_address"
    t.string   "city"
    t.string   "state_code"
    t.string   "postal_code"
    t.string   "country_code"
    t.string   "cross_streets"
    t.boolean  "is_claimed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "yelp_id"
    t.decimal  "lat",                  precision: 10, scale: 6
    t.decimal  "lng",                  precision: 10, scale: 6
    t.integer  "parking_spaces"
  end

  create_table "businesses_categories", force: true do |t|
    t.integer "business_id"
    t.integer "category_id"
  end

  add_index "businesses_categories", ["business_id"], name: "index_businesses_categories_on_business_id", using: :btree
  add_index "businesses_categories", ["category_id"], name: "index_businesses_categories_on_category_id", using: :btree

  create_table "businesses_neighborhoods", force: true do |t|
    t.integer "business_id"
    t.integer "neighborhood_id"
  end

  add_index "businesses_neighborhoods", ["business_id"], name: "index_businesses_neighborhoods_on_business_id", using: :btree
  add_index "businesses_neighborhoods", ["neighborhood_id"], name: "index_businesses_neighborhoods_on_neighborhood_id", using: :btree

  create_table "businesses_parking_options", force: true do |t|
    t.integer "business_id"
    t.integer "parking_option_id"
  end

  add_index "businesses_parking_options", ["business_id"], name: "index_businesses_parking_options_on_business_id", using: :btree
  add_index "businesses_parking_options", ["parking_option_id"], name: "index_businesses_parking_options_on_parking_option_id", using: :btree

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.string   "url"
    t.string   "datetime_local"
    t.string   "short_title"
    t.string   "datetime_utc"
    t.integer  "score"
    t.string   "event_type"
    t.integer  "seatgeek_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events_performers", force: true do |t|
    t.integer "event_id"
    t.integer "performer_id"
  end

  add_index "events_performers", ["event_id"], name: "index_events_performers_on_event_id", using: :btree
  add_index "events_performers", ["performer_id"], name: "index_events_performers_on_performer_id", using: :btree

  create_table "events_venues", force: true do |t|
    t.integer "event_id"
    t.integer "venue_id"
  end

  add_index "events_venues", ["event_id"], name: "index_events_venues_on_event_id", using: :btree
  add_index "events_venues", ["venue_id"], name: "index_events_venues_on_venue_id", using: :btree

  create_table "neighborhoods", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parking_options", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performers", force: true do |t|
    t.string   "name"
    t.string   "short_name"
    t.string   "url"
    t.string   "image"
    t.string   "image_large"
    t.string   "image_huge"
    t.integer  "seatgeek_id"
    t.string   "score"
    t.string   "performer_type"
    t.string   "slug"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

  create_table "venues", force: true do |t|
    t.string   "city"
    t.string   "name"
    t.string   "url"
    t.string   "country"
    t.string   "state"
    t.integer  "score"
    t.string   "postal_code"
    t.float    "lat",         limit: 24
    t.float    "lng",         limit: 24
    t.string   "address"
    t.integer  "seatgeek_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "event_id"
  end

end
