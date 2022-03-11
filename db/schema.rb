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

ActiveRecord::Schema.define(version: 2022_03_09_232116) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "badge"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "recurrence_id"
    t.bigint "user_profile_id"
    t.string "title"
    t.string "description"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["recurrence_id"], name: "index_notifications_on_recurrence_id"
    t.index ["user_profile_id"], name: "index_notifications_on_user_profile_id"
  end

  create_table "recurrences", force: :cascade do |t|
    t.bigint "user_profile_id"
    t.bigint "category_id"
    t.string "title"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BRL", null: false
    t.boolean "pay", default: false
    t.datetime "date_expire", default: "2022-03-11 00:00:00"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_recurrences_on_category_id"
    t.index ["user_profile_id"], name: "index_recurrences_on_user_profile_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.bigint "recurrence_id"
    t.string "title"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "BRL", null: false
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_profile_id"
    t.index ["recurrence_id"], name: "index_transactions_on_recurrence_id"
    t.index ["user_profile_id"], name: "index_transactions_on_user_profile_id"
  end

  create_table "user_profiles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_profiles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "notifications", "recurrences"
  add_foreign_key "notifications", "user_profiles"
  add_foreign_key "recurrences", "categories"
  add_foreign_key "recurrences", "user_profiles"
  add_foreign_key "transactions", "recurrences"
  add_foreign_key "transactions", "user_profiles"
  add_foreign_key "user_profiles", "users"
end
