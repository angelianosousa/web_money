# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_03_29_043653) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "title"
    t.decimal "price_cents", default: "0.0", null: false
    t.string "price_currency", default: "BRL", null: false
    t.bigint "user_profile_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_profile_id"], name: "index_accounts_on_user_profile_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "bills", force: :cascade do |t|
    t.string "title"
    t.decimal "price_cents"
    t.date "due_pay", default: "2023-07-04"
    t.integer "bill_type"
    t.integer "status", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_profile_id", null: false
    t.index ["user_profile_id"], name: "index_bills_on_user_profile_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "user_profile_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "category_type", default: 0
    t.index ["user_profile_id"], name: "index_categories_on_user_profile_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_profile_id"
    t.string "title"
    t.string "description"
    t.boolean "read", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_profile_id"], name: "index_notifications_on_user_profile_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "price_cents", default: "0.0", null: false
    t.string "price_currency", default: "BRL", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_profile_id"
    t.bigint "category_id", null: false
    t.bigint "account_id"
    t.text "description"
    t.bigint "bill_id"
    t.index ["account_id"], name: "index_transactions_on_account_id"
    t.index ["bill_id"], name: "index_transactions_on_bill_id"
    t.index ["category_id"], name: "index_transactions_on_category_id"
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

  add_foreign_key "accounts", "user_profiles"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "bills", "user_profiles"
  add_foreign_key "categories", "user_profiles"
  add_foreign_key "notifications", "user_profiles"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "transactions", "bills"
  add_foreign_key "transactions", "categories"
  add_foreign_key "transactions", "user_profiles"
  add_foreign_key "user_profiles", "users"
end
