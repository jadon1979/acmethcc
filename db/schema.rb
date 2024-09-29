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

ActiveRecord::Schema[7.0].define(version: 2024_09_29_015757) do
  create_table "message_channels", force: :cascade do |t|
    t.integer "initiator_id"
    t.integer "responder_id"
    t.integer "status", default: 0
    t.integer "message_for", default: 0
    t.integer "message_for_id", default: 0
    t.integer "updated_by"
    t.string "close_reason"
    t.integer "messages_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["initiator_id"], name: "index_message_channels_on_initiator_id"
    t.index ["responder_id"], name: "index_message_channels_on_responder_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "doctor_id"
    t.integer "order_id"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "message_channel_id", null: false
    t.index ["doctor_id"], name: "index_messages_on_doctor_id"
    t.index ["order_id"], name: "index_messages_on_order_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "order_payment_details", force: :cascade do |t|
    t.integer "order_id", null: false
    t.integer "payment_detail_id", null: false
    t.decimal "total"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_payment_details_on_order_id"
    t.index ["payment_detail_id"], name: "index_order_payment_details_on_payment_detail_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "doctor_id", null: false
    t.string "order_items"
    t.decimal "total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["doctor_id"], name: "index_orders_on_doctor_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payment_details", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "encrypted_credit_card_number"
    t.string "full_name"
    t.string "expiration"
    t.integer "last_four_digits"
    t.string "zip_code"
    t.integer "payment_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "user_type", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "message_channels", "users", column: "initiator_id"
  add_foreign_key "message_channels", "users", column: "responder_id"
  add_foreign_key "messages", "orders"
  add_foreign_key "messages", "users"
  add_foreign_key "messages", "users", column: "doctor_id"
  add_foreign_key "order_payment_details", "orders"
  add_foreign_key "order_payment_details", "payment_details"
  add_foreign_key "orders", "users"
  add_foreign_key "orders", "users", column: "doctor_id"
end
