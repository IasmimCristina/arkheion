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

ActiveRecord::Schema[8.1].define(version: 2025_12_05_130422) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "annotations", force: :cascade do |t|
    t.string "category"
    t.bigint "character_sheet_id", null: false
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["character_sheet_id"], name: "index_annotations_on_character_sheet_id"
  end

  create_table "character_attacks", force: :cascade do |t|
    t.string "attack_bonus"
    t.string "attack_type"
    t.bigint "character_sheet_id", null: false
    t.datetime "created_at", null: false
    t.string "critical"
    t.string "damage"
    t.string "name"
    t.string "range"
    t.datetime "updated_at", null: false
    t.index ["character_sheet_id"], name: "index_character_attacks_on_character_sheet_id"
  end

  create_table "character_attributes", force: :cascade do |t|
    t.bigint "character_sheet_id", null: false
    t.integer "charisma"
    t.integer "constitution"
    t.datetime "created_at", null: false
    t.integer "dexterity"
    t.integer "intelligence"
    t.integer "strength"
    t.datetime "updated_at", null: false
    t.integer "wisdom"
    t.index ["character_sheet_id"], name: "index_character_attributes_on_character_sheet_id"
  end

  create_table "character_combats", force: :cascade do |t|
    t.integer "armor_bonus"
    t.bigint "character_sheet_id", null: false
    t.datetime "created_at", null: false
    t.integer "defense"
    t.integer "hit_points_current"
    t.integer "hit_points_max"
    t.integer "mana_points_current"
    t.integer "mana_points_max"
    t.integer "shield_bonus"
    t.datetime "updated_at", null: false
    t.index ["character_sheet_id"], name: "index_character_combats_on_character_sheet_id"
  end

  create_table "character_equipments", force: :cascade do |t|
    t.bigint "character_sheet_id", null: false
    t.datetime "created_at", null: false
    t.boolean "equipped"
    t.string "name"
    t.integer "quantity"
    t.datetime "updated_at", null: false
    t.decimal "weight"
    t.index ["character_sheet_id"], name: "index_character_equipments_on_character_sheet_id"
  end

  create_table "character_infos", force: :cascade do |t|
    t.string "character_class"
    t.string "character_name"
    t.bigint "character_sheet_id", null: false
    t.datetime "created_at", null: false
    t.string "divinity"
    t.integer "level"
    t.string "origin"
    t.string "race"
    t.datetime "updated_at", null: false
    t.index ["character_sheet_id"], name: "index_character_infos_on_character_sheet_id"
  end

  create_table "character_sheets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "name"
    t.string "player_name"
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_character_sheets_on_user_id"
  end

  create_table "character_skills", force: :cascade do |t|
    t.string "attribute_type"
    t.bigint "character_sheet_id", null: false
    t.datetime "created_at", null: false
    t.string "name"
    t.integer "other_bonus"
    t.integer "total"
    t.boolean "trained_only"
    t.integer "training_bonus"
    t.datetime "updated_at", null: false
    t.index ["character_sheet_id"], name: "index_character_skills_on_character_sheet_id"
  end

  create_table "character_spells", force: :cascade do |t|
    t.bigint "character_sheet_id", null: false
    t.datetime "created_at", null: false
    t.text "description"
    t.integer "level"
    t.string "name"
    t.string "school"
    t.datetime "updated_at", null: false
    t.index ["character_sheet_id"], name: "index_character_spells_on_character_sheet_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "annotations", "character_sheets"
  add_foreign_key "character_attacks", "character_sheets"
  add_foreign_key "character_attributes", "character_sheets"
  add_foreign_key "character_combats", "character_sheets"
  add_foreign_key "character_equipments", "character_sheets"
  add_foreign_key "character_infos", "character_sheets"
  add_foreign_key "character_sheets", "users"
  add_foreign_key "character_skills", "character_sheets"
  add_foreign_key "character_spells", "character_sheets"
end
