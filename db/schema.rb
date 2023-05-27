# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_05_26_221422) do
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "answers", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "question_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "product_batch_id", null: false
    t.index ["product_batch_id"], name: "index_answers_on_product_batch_id"
    t.index ["question_id"], name: "index_answers_on_question_id"
    t.index ["user_id"], name: "index_answers_on_user_id"
  end

  create_table "bids", force: :cascade do |t|
    t.decimal "value"
    t.integer "product_batch_id", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_batch_id"], name: "index_bids_on_product_batch_id"
    t.index ["user_id"], name: "index_bids_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_batch_items", force: :cascade do |t|
    t.integer "product_batch_id", null: false
    t.integer "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_batch_id"], name: "index_product_batch_items_on_product_batch_id"
    t.index ["product_id"], name: "index_product_batch_items_on_product_id"
  end

  create_table "product_batches", force: :cascade do |t|
    t.string "code"
    t.datetime "start_date"
    t.datetime "deadline"
    t.decimal "minimum_value"
    t.decimal "minimal_difference"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin_id", default: 0, null: false
    t.integer "created_by_id"
    t.integer "approved_by_id"
    t.datetime "start_time", precision: nil
    t.datetime "end_time", precision: nil
    t.integer "expired", default: 0
    t.index ["admin_id"], name: "index_product_batches_on_admin_id"
    t.index ["approved_by_id"], name: "index_product_batches_on_approved_by_id"
    t.index ["created_by_id"], name: "index_product_batches_on_created_by_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.string "photo"
    t.integer "weight"
    t.integer "width"
    t.integer "height"
    t.integer "depth"
    t.string "description"
    t.string "code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id", default: 0, null: false
    t.integer "status", default: 2
    t.index ["category_id"], name: "index_products_on_category_id"
  end

  create_table "questions", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "product_batch_id", null: false
    t.boolean "hidden", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_batch_id"], name: "index_questions_on_product_batch_id"
    t.index ["user_id"], name: "index_questions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "cpf"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.boolean "blocked", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "answers", "product_batches"
  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "bids", "product_batches"
  add_foreign_key "bids", "users"
  add_foreign_key "product_batch_items", "product_batches"
  add_foreign_key "product_batch_items", "products"
  add_foreign_key "product_batches", "admins"
  add_foreign_key "products", "categories"
  add_foreign_key "questions", "product_batches"
  add_foreign_key "questions", "users"
end
