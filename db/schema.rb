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

ActiveRecord::Schema.define(version: 20140119034241) do

  create_table "abouts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "me"
    t.text     "family"
    t.text     "education"
    t.text     "work"
    t.text     "future"
  end

  create_table "contacts", force: true do |t|
    t.integer  "user_id"
    t.string   "country",      limit: 32
    t.string   "city",         limit: 32
    t.string   "residency",    limit: 32
    t.text     "address"
    t.string   "mother_no",    limit: 32, default: ""
    t.integer  "best_time_m"
    t.string   "father_no",    limit: 32
    t.integer  "best_time_f"
    t.string   "self_no",      limit: 32
    t.integer  "best_time_s"
    t.string   "chat_id",      limit: 32
    t.string   "chat_service", limit: 32
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "fb_link"
    t.text     "ln_link"
  end

  create_table "interests", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.text     "message"
    t.integer  "response"
  end

  create_table "kundalis", force: true do |t|
    t.integer  "user_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.string   "birth_country", limit: 32
    t.string   "birth_city",    limit: 32
    t.date     "dob"
    t.date     "tob"
    t.integer  "manglik"
    t.string   "sub_sign",      limit: 32
    t.string   "moon_sign",     limit: 32
    t.string   "nakshatra",     limit: 32
  end

  create_table "profiles", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "sex",            limit: 32
    t.integer  "posted_by"
    t.date     "dob"
    t.integer  "marital_status"
  end

  create_table "religions", force: true do |t|
    t.integer  "user_id"
    t.string   "religion",      limit: 32
    t.string   "mother_tongue", limit: 32
    t.string   "caste",         limit: 32
    t.string   "sub_caste",     limit: 32
    t.string   "native_place",  limit: 32
    t.string   "gothra",        limit: 32
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visitors", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "viewed_id"
  end

end
