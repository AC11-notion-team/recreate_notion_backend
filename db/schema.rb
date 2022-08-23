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

ActiveRecord::Schema.define(version: 2022_08_23_115021) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.string "object"
    t.uuid "uuid"
    t.json "parent"
    t.string "type"
    t.json "created_by"
    t.json "last_edited_by"
    t.boolean "archived"
    t.boolean "has_children"
    t.json "type_specific_info"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "databases", force: :cascade do |t|
    t.string "object"
    t.uuid "uuid"
    t.json "created_by"
    t.json "last_edited_by"
    t.json "title"
    t.text "description"
    t.json "properties"
    t.json "icon"
    t.json "cover"
    t.json "parent"
    t.string "url"
    t.boolean "archived"
    t.boolean "is_inline"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string "object"
    t.uuid "uuid"
    t.json "created_by"
    t.json "last_edited_by"
    t.boolean "archived"
    t.json "icon"
    t.json "cover"
    t.json "properties"
    t.json "parent"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
