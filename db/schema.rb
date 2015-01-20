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

ActiveRecord::Schema.define(version: 20150120082353) do

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
  end

  create_table "businesses_categories", force: true do |t|
    t.integer "business_id"
    t.integer "category_id"
  end

  add_index "businesses_categories", ["business_id"], name: "index_businesses_categories_on_business_id"
  add_index "businesses_categories", ["category_id"], name: "index_businesses_categories_on_category_id"

  create_table "businesses_neighborhoods", force: true do |t|
    t.integer "business_id"
    t.integer "neighborhood_id"
  end

  add_index "businesses_neighborhoods", ["business_id"], name: "index_businesses_neighborhoods_on_business_id"
  add_index "businesses_neighborhoods", ["neighborhood_id"], name: "index_businesses_neighborhoods_on_neighborhood_id"

  create_table "businesses_parking_options", force: true do |t|
    t.integer "business_id"
    t.integer "parking_option_id"
  end

  add_index "businesses_parking_options", ["business_id"], name: "index_businesses_parking_options_on_business_id"
  add_index "businesses_parking_options", ["parking_option_id"], name: "index_businesses_parking_options_on_parking_option_id"

  create_table "categories", force: true do |t|
    t.string   "name"
    t.string   "alias"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

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

end
