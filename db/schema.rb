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

ActiveRecord::Schema.define(version: 20140331134717) do

  create_table "abouts", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "me"
  end

  create_table "contacts", force: true do |t|
    t.integer  "user_id"
    t.text     "address"
    t.string   "mother_no",  limit: 32, default: ""
    t.string   "father_no",  limit: 32
    t.string   "self_no",    limit: 32
    t.string   "g_id"
    t.string   "s_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "ln_link"
    t.string   "w_id"
    t.text     "fb_link"
  end

  create_table "desires", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "desired_about"
    t.string   "desired_height",         limit: 32
    t.string   "desired_age",            limit: 32
    t.string   "desired_marital_status", limit: 32
    t.string   "desired_country",        limit: 64
    t.string   "desired_city",           limit: 64
    t.string   "desired_religion",       limit: 64,  default: ""
    t.string   "desired_caste",          limit: 64
    t.string   "desired_mother_tongue",  limit: 64
    t.string   "desired_manglik",        limit: 32
    t.string   "desired_diet",           limit: 64
    t.string   "desired_smoke",          limit: 32
    t.string   "desired_drink",          limit: 32
    t.string   "desired_complexion",     limit: 64
    t.string   "desired_body",           limit: 32
    t.string   "desired_challenged",     limit: 4
    t.string   "desired_education",      limit: 128
    t.string   "desired_occupation",     limit: 128
    t.string   "desired_income",         limit: 64
    t.text     "desired_notes"
  end

  create_table "educations", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "school"
    t.text     "grad_college"
    t.text     "post_grad"
    t.text     "post_grad_college"
    t.text     "highest_degree"
    t.text     "graduation"
  end

  create_table "families", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "values"
    t.string   "size"
    t.string   "status"
    t.string   "family_income"
    t.text     "father"
    t.text     "mother"
    t.text     "brother"
    t.text     "sister"
    t.string   "profile_handler", limit: 64, default: ""
  end

  create_table "hobbies", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "hobby"
    t.text     "interest"
    t.text     "music"
    t.text     "read"
    t.text     "dress"
    t.text     "tv"
    t.text     "movie"
    t.text     "sport"
    t.text     "cuisine"
    t.text     "vacation"
  end

  create_table "images", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "interests", force: true do |t|
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.integer  "response"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "kundalis", force: true do |t|
    t.integer  "user_id"
    t.datetime "updated_at"
    t.datetime "created_at"
    t.text     "birth_country"
    t.text     "birth_city"
    t.text     "tob"
    t.text     "manglik"
    t.text     "sun_sign"
    t.text     "moon_sign"
    t.text     "nakshatra"
  end

  create_table "lifestyles", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "diet"
    t.string   "smoke"
    t.string   "drink"
    t.string   "complexion"
    t.string   "blood",      limit: 4
    t.string   "weight",     limit: 4
    t.string   "own_house",  limit: 64
    t.string   "own_car",    limit: 64
    t.string   "pet",        limit: 64
    t.string   "hiv",        limit: 4
    t.string   "height",     limit: 4
  end

  create_table "notifications", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "to_user_id"
    t.integer  "flag",       limit: 1
    t.integer  "seen",       limit: 1
  end

  create_table "occupations", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "status"
    t.text     "occupation"
    t.text     "company"
    t.text     "annual_income"
    t.text     "setting_abroad"
  end

  create_table "profiles", force: true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "posted_by",      limit: 64, default: "Self"
    t.string   "marital_status", limit: 64
    t.string   "home"
  end

  create_table "religions", force: true do |t|
    t.integer  "user_id"
    t.text     "mother_tongue"
    t.text     "caste"
    t.text     "sub_caste"
    t.text     "native_place"
    t.datetime "updated_at"
    t.datetime "created_at"
  end

  create_table "shortlists", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id",    limit: 8
    t.integer  "to_user_id", limit: 8
  end

  create_table "users", force: true do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sex",                    limit: 8
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name",                   limit: 64
    t.string   "dob",                    limit: 64
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "devotion"
    t.integer  "images_count",           limit: 1
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "visitors", force: true do |t|
    t.integer  "user_id"
    t.integer  "viewed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
