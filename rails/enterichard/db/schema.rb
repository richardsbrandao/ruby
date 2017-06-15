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

ActiveRecord::Schema.define(version: 20170615001300) do

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.date "foundation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_companies_on_deleted_at"
  end

  create_table "employees", force: :cascade do |t|
    t.string "name"
    t.date "birthday"
    t.string "gender"
    t.string "city"
    t.integer "vacancy_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["vacancy_id"], name: "index_employees_on_vacancy_id"
  end

  create_table "employees_skills", id: false, force: :cascade do |t|
    t.integer "skill_id", null: false
    t.integer "employee_id", null: false
    t.index ["employee_id", "skill_id"], name: "index_employees_skills_on_employee_id_and_skill_id"
    t.index ["skill_id", "employee_id"], name: "index_employees_skills_on_skill_id_and_employee_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills_vacancies", id: false, force: :cascade do |t|
    t.integer "skill_id", null: false
    t.integer "vacancy_id", null: false
    t.index ["skill_id", "vacancy_id"], name: "index_skills_vacancies_on_skill_id_and_vacancy_id"
    t.index ["vacancy_id", "skill_id"], name: "index_skills_vacancies_on_vacancy_id_and_skill_id"
  end

  create_table "vacancies", force: :cascade do |t|
    t.string "position"
    t.integer "salary"
    t.integer "company_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["company_id"], name: "index_vacancies_on_company_id"
    t.index ["deleted_at"], name: "index_vacancies_on_deleted_at"
  end

end
