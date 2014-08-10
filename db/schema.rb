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

ActiveRecord::Schema.define(version: 20140809205030) do

  create_table "countdowns", force: true do |t|
    t.string   "twitter_id"
    t.string   "name"
    t.string   "image"
    t.string   "hashtag"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string   "title"
    t.text     "start_description"
    t.text     "end_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "site"
  end

  add_index "countdowns", ["name"], name: "index_countdowns_on_name"
  add_index "countdowns", ["twitter_id"], name: "index_countdowns_on_twitter_id"

end
