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

ActiveRecord::Schema.define(version: 2021_08_06_163436) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessplatforms", force: :cascade do |t|
    t.integer "accessok"
    t.integer "accesserror"
    t.date "pdate"
    t.string "reason"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "arquivos", force: :cascade do |t|
    t.string "diretorio_arquivo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "description"
    t.string "idfb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "abrev"
    t.integer "indice"
    t.integer "status"
  end

  create_table "kinds", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "registrations", force: :cascade do |t|
    t.bigint "student_id"
    t.bigint "team_id"
    t.integer "year"
    t.string "idfb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.integer "kind"
    t.integer "indice"
    t.index ["student_id"], name: "index_registrations_on_student_id"
    t.index ["team_id"], name: "index_registrations_on_team_id"
  end

  create_table "statusapps", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "code"
    t.string "datebirthday"
    t.string "idfb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
  end

  create_table "teamdiscs", force: :cascade do |t|
    t.bigint "team_id"
    t.bigint "discipline_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "indice"
    t.index ["discipline_id"], name: "index_teamdiscs_on_discipline_id"
    t.index ["team_id"], name: "index_teamdiscs_on_team_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "description"
    t.integer "year"
    t.string "idfb"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "kind"
    t.integer "status"
    t.integer "pesqstatus"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "admin"
    t.bigint "kind_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["kind_id"], name: "index_users_on_kind_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "registrations", "students"
  add_foreign_key "registrations", "teams"
  add_foreign_key "teamdiscs", "disciplines"
  add_foreign_key "teamdiscs", "teams"
end
