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

ActiveRecord::Schema[8.1].define(version: 2026_11_09_120835) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "diaries", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title", null: false
    t.text "body", null: false
    t.date "written_on", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "poem_id"
    t.index ["poem_id"], name: "index_diaries_on_poem_id"
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "keywords", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_keywords_on_name", unique: true
  end

  create_table "poem_keywords", force: :cascade do |t|
    t.bigint "poem_id", null: false
    t.bigint "keyword_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["keyword_id"], name: "index_poem_keywords_on_keyword_id"
    t.index ["poem_id", "keyword_id"], name: "index_poem_keywords_on_poem_id_and_keyword_id", unique: true
    t.index ["poem_id"], name: "index_poem_keywords_on_poem_id"
  end

  create_table "poems", force: :cascade do |t|
    t.integer "number", null: false
    t.string "kami_no_ku", null: false
    t.string "shimo_no_ku", null: false
    t.string "poet", null: false
    t.text "translation", null: false
    t.text "explanation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["number"], name: "index_poems_on_number", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "diaries", "poems"
  add_foreign_key "diaries", "users"
  add_foreign_key "poem_keywords", "keywords"
  add_foreign_key "poem_keywords", "poems"
end
