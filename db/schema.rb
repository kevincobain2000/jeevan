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

ActiveRecord::Schema.define(version: 20140126021927) do

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
    t.string   "father_no",    limit: 32
    t.string   "self_no",      limit: 32
    t.string   "chat_id",      limit: 32
    t.string   "chat_service", limit: 32
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "fb_link"
    t.text     "ln_link"
    t.string   "best_time_f",  limit: 32
    t.string   "best_time_t",  limit: 32
  end

  create_table "desires", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "about"
    t.integer  "height"
    t.integer  "age"
    t.integer  "marital_status"
    t.integer  "country"
    t.integer  "city"
    t.string   "religion",       limit: 64, default: ""
    t.string   "caste",          limit: 64
    t.string   "mother_toungue", limit: 64
    t.integer  "manglik",        limit: 1
    t.integer  "diet",           limit: 1
    t.integer  "smoke",          limit: 1
    t.integer  "drink",          limit: 1
    t.integer  "complexion",     limit: 1
    t.integer  "body",           limit: 1
    t.integer  "challenged",     limit: 1
    t.integer  "education"
    t.integer  "occupation"
    t.integer  "income"
    t.text     "notes"
  end

  create_table "educations", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "school",            limit: 64
    t.string   "grad_college",      limit: 64
    t.string   "grad",              limit: 32
    t.string   "post_grad",         limit: 32
    t.string   "post_grad_college", limit: 64
    t.string   "highest_degree",    limit: 32
  end

  create_table "families", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "values",          limit: 32
    t.string   "type",            limit: 32
    t.string   "status",          limit: 32
    t.integer  "income"
    t.string   "father",          limit: 32
    t.string   "mother",          limit: 32
    t.integer  "brother"
    t.integer  "sister"
    t.string   "profile_handler", limit: 32
  end

  create_table "hobbies", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "hobbies"
    t.text     "interests"
    t.text     "music"
    t.text     "read"
    t.text     "dress"
    t.text     "tv"
    t.text     "movie"
    t.text     "sport"
    t.text     "cuisine"
    t.text     "vacation"
  end

  create_table "interests", force: true do |t|
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.text     "message"
    t.integer  "response"
    t.datetime "created_at"
    t.datetime "updated_at"
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

  create_table "lifestyles", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "diet"
    t.integer  "smoke"
    t.integer  "drink"
    t.integer  "complexion"
    t.integer  "body"
    t.integer  "challenged"
    t.integer  "blood"
    t.integer  "weight"
    t.integer  "residense"
    t.integer  "own_house"
    t.integer  "own_car"
    t.text     "language"
    t.integer  "pet"
    t.integer  "hiv"
    t.integer  "height"
  end

  create_table "occupations", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status"
    t.string   "occupation",     limit: 64
    t.string   "company",        limit: 64
    t.integer  "annual_income"
    t.integer  "setting_abroad"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sex",            limit: 32
    t.integer  "posted_by"
    t.date     "dob"
    t.string   "marital_status", limit: 32
  end

  create_table "religions", force: true do |t|
    t.integer  "user_id"
    t.string   "religion",      limit: 64
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
    t.integer  "user_id"
    t.integer  "viewed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
