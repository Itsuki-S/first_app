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

ActiveRecord::Schema.define(version: 2021_02_08_035440) do

  create_table "diving_logs", force: :cascade do |t|
    t.integer "dive_number"
    t.string "address"
    t.float "latitude"
    t.float "longitude"
    t.string "point"
    t.string "entry"
    t.datetime "entry_time"
    t.datetime "exit_time"
    t.integer "entry_bar"
    t.integer "exit_bar"
    t.float "air_temperature"
    t.float "water_temperature"
    t.string "condition"
    t.integer "transparency"
    t.float "ave_depth"
    t.float "max_depth"
    t.string "equipment"
    t.text "comment"
    t.boolean "published", default: true
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "images"
    t.index ["user_id", "entry_time"], name: "index_diving_logs_on_user_id_and_entry_time"
    t.index ["user_id"], name: "index_diving_logs_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin"
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "diving_logs", "users"
end
