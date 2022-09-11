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

ActiveRecord::Schema[7.0].define(version: 2022_09_07_124044) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "stocks", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "code"
    t.string "name"
    t.integer "volume"
    t.index ["code"], name: "index_stocks_on_code"
  end

  create_table "stocks_traders", id: false, force: :cascade do |t|
    t.bigint "trader_id", null: false
    t.bigint "stock_id", null: false
    t.integer "volume", default: 0
    t.index ["stock_id", "trader_id"], name: "index_stocks_traders_on_stock_id_and_trader_id"
    t.index ["trader_id", "stock_id"], name: "index_stocks_traders_on_trader_id_and_stock_id"
  end

  create_table "traders", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false
    t.integer "age"
    t.string "first_name"
    t.string "last_name"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.decimal "cash", default: "10000.0"
    t.boolean "approved_boolean", default: false
    t.index ["confirmation_token"], name: "index_traders_on_confirmation_token", unique: true
    t.index ["email"], name: "index_traders_on_email", unique: true
    t.index ["reset_password_token"], name: "index_traders_on_reset_password_token", unique: true
  end

  create_table "transactions", force: :cascade do |t|
    t.decimal "price"
    t.integer "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stock_id"
    t.integer "trader_id"
    t.boolean "transaction_type"
  end

end
