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

ActiveRecord::Schema.define(version: 20161112200058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "documents", force: :cascade do |t|
    t.string   "discipline_code"
    t.string   "discipline_name"
    t.string   "field_of_study_code"
    t.string   "field_of_study_name"
    t.string   "speciality_name"
    t.string   "specialization_name"
    t.string   "faculty_name"
    t.string   "type_of_control"
    t.integer  "labs_time"
    t.integer  "credits_count"
    t.integer  "lectures_time"
    t.integer  "semester_number"
    t.integer  "year_of_studying"
    t.integer  "self_hours_count"
    t.integer  "total_hours_count"
    t.integer  "user_id",                                null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "cathedra_name"
    t.string   "groups_codes"
    t.string   "head_of_department"
    t.string   "program_department_approved_date"
    t.string   "head_of_commission"
    t.string   "program_commission_approved_date"
    t.string   "head_of_academic_council"
    t.string   "program_academic_council_approved_date"
    t.index ["user_id"], name: "index_documents_on_user_id", using: :btree
  end

  create_table "main_modules", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "total_time"
    t.integer  "document_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["document_id"], name: "index_main_modules_on_document_id", using: :btree
  end

  create_table "scientists", force: :cascade do |t|
    t.string   "name"
    t.string   "position"
    t.integer  "document_id", null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["document_id"], name: "index_scientists_on_document_id", using: :btree
  end

  create_table "sub_modules", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "labs_time"
    t.integer  "lectures_time"
    t.integer  "main_module_id", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["main_module_id"], name: "index_sub_modules_on_main_module_id", using: :btree
  end

  create_table "topics", force: :cascade do |t|
    t.string   "name"
    t.integer  "position"
    t.integer  "sub_module_id",  null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "labs_time"
    t.integer  "lectures_time"
    t.boolean  "calculate_time"
    t.index ["sub_module_id"], name: "index_topics_on_sub_module_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "documents", "users"
  add_foreign_key "main_modules", "documents"
  add_foreign_key "scientists", "documents"
  add_foreign_key "sub_modules", "main_modules"
  add_foreign_key "topics", "sub_modules"
end
