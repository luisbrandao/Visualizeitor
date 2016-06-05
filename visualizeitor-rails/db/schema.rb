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

ActiveRecord::Schema.define(version: 20160605161344) do

  create_table "acforms", force: :cascade do |t|
    t.integer  "state"
    t.integer  "student_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "acforms", ["student_id"], name: "index_acforms_on_student_id"

  create_table "activities", force: :cascade do |t|
    t.date     "start"
    t.date     "end"
    t.integer  "hours"
    t.integer  "hoursvalid"
    t.integer  "acform_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "activities", ["acform_id"], name: "index_activities_on_acform_id"
  add_index "activities", ["category_id"], name: "index_activities_on_category_id"

  create_table "categories", force: :cascade do |t|
    t.string   "descr"
    t.integer  "softlimit"
    t.integer  "hardlimit"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.string   "cnpj"
    t.string   "activity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "qualification"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "phone"
    t.integer  "company_id"
  end

  add_index "contacts", ["company_id"], name: "index_contacts_on_company_id"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: :cascade do |t|
    t.string   "descr"
    t.integer  "activity_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "documents", ["activity_id"], name: "index_documents_on_activity_id"

  create_table "enrollments", force: :cascade do |t|
    t.decimal  "grade"
    t.decimal  "frequency"
    t.integer  "year"
    t.integer  "semester"
    t.string   "status"
    t.string   "enrollment_type"
    t.integer  "student_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluations", force: :cascade do |t|
    t.string   "state"
    t.integer  "teacher_id"
    t.integer  "acform_id"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "evaluations", ["acform_id"], name: "index_evaluations_on_acform_id"
  add_index "evaluations", ["teacher_id"], name: "index_evaluations_on_teacher_id"

  create_table "internships", force: :cascade do |t|
    t.date     "start"
    t.date     "end"
    t.integer  "hours"
    t.integer  "assistType"
    t.integer  "internType"
    t.integer  "student_id"
    t.integer  "teacher_id"
    t.integer  "contact_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "assignment"
    t.text     "goals"
  end

  add_index "internships", ["contact_id"], name: "index_internships_on_contact_id"
  add_index "internships", ["student_id"], name: "index_internships_on_student_id"
  add_index "internships", ["teacher_id"], name: "index_internships_on_teacher_id"

  create_table "majors", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "program_items", force: :cascade do |t|
    t.integer  "row"
    t.integer  "column"
    t.integer  "program_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "programs", force: :cascade do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "year"
    t.integer  "major_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: :cascade do |t|
    t.string   "name"
    t.string   "grr",                                 null: false
    t.integer  "program_id"
    t.integer  "major_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "students", ["grr"], name: "index_students_on_grr", unique: true
  add_index "students", ["reset_password_token"], name: "index_students_on_reset_password_token", unique: true

  create_table "teachers", force: :cascade do |t|
    t.string   "name"
    t.string   "login",                               null: false
    t.integer  "access",                 default: 0,  null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "teachers", ["login"], name: "index_teachers_on_login", unique: true
  add_index "teachers", ["reset_password_token"], name: "index_teachers_on_reset_password_token", unique: true

end
