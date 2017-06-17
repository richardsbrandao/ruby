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

ActiveRecord::Schema.define(version: 20170616033308) do

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.integer "year"
    t.integer "value"
    t.decimal "monthly_input"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "index_values", force: :cascade do |t|
    t.string "period"
    t.decimal "value"
    t.integer "index_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index_id"], name: "index_index_values_on_index_id"
  end

  create_table "indices", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "investiments", force: :cascade do |t|
    t.string "name"
    t.string "model"
    t.decimal "year_yield", precision: 8, scale: 2
    t.integer "ir_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ir_id"], name: "index_investiments_on_ir_id"
  end

  create_table "irs", force: :cascade do |t|
    t.string "tax"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "saved_money_percentages", force: :cascade do |t|
    t.integer "value"
    t.integer "saved_money_id"
    t.integer "goal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["goal_id"], name: "index_saved_money_percentages_on_goal_id"
    t.index ["saved_money_id"], name: "index_saved_money_percentages_on_saved_money_id"
  end

  create_table "saved_moneys", force: :cascade do |t|
    t.decimal "value", precision: 8, scale: 2
    t.datetime "date"
    t.integer "investiment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["investiment_id"], name: "index_saved_moneys_on_investiment_id"
  end

end
