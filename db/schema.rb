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

<<<<<<< HEAD
ActiveRecord::Schema.define(version: 2022_09_09_095406) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.uuid "page_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "kind"
    t.json "data"
    t.string "blockID"
    t.integer "index_number"
    t.string "prev_blockID"
    t.index ["blockID"], name: "index_blocks_on_blockID"
    t.index ["page_id"], name: "index_blocks_on_page_id"
    t.index ["user_id"], name: "index_blocks_on_user_id"
  end

  create_table "pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "icon"
    t.string "cover"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.string "title", default: "Untitled"
    t.string "tail"
    t.boolean "share", default: false
    t.boolean "editable", default: false
=======
ActiveRecord::Schema.define(version: 2022_09_14_000642) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "blocks", force: :cascade do |t|
    t.uuid "page_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "kind"
    t.json "data"
    t.string "blockID"
    t.integer "index_number"
    t.string "prev_blockID"
    t.datetime "deleted_at"
    t.index ["blockID"], name: "index_blocks_on_blockID"
    t.index ["deleted_at"], name: "index_blocks_on_deleted_at"
    t.index ["page_id"], name: "index_blocks_on_page_id"
    t.index ["user_id"], name: "index_blocks_on_user_id"
  end

  create_table "pages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "icon", default: "🗒️"
    t.string "cover"
    t.string "url"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.string "title", default: "Untitled"
    t.string "tail"
    t.boolean "share", default: false
    t.boolean "editable", default: false
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_pages_on_deleted_at"
  end

  create_table "sharepages", force: :cascade do |t|
    t.bigint "user_id"
    t.string "permission"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.uuid "page_id"
    t.index ["user_id"], name: "index_sharepages_on_user_id"
>>>>>>> 09d8767f2869379c8195ce37403f65b07d3f4877
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "email_confirmed"
    t.string "confirm_token"
    t.string "password_digest"
    t.boolean "third_party"
    t.string "image"
    t.boolean "vertify_status"
  end

end
