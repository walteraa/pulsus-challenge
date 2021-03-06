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

ActiveRecord::Schema.define(version: 2021_03_01_114755) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "drived_transports", force: :cascade do |t|
    t.integer "person_id"
    t.integer "transport_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_drived_transports_on_person_id"
    t.index ["transport_id"], name: "index_drived_transports_on_transport_id"
  end

  create_table "people", force: :cascade do |t|
    t.string "name", null: false
    t.string "birthday_year", null: false
    t.integer "height", null: false
    t.integer "mass", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "planet_id"
    t.index ["planet_id"], name: "index_people_on_planet_id"
  end

  create_table "person_species", force: :cascade do |t|
    t.integer "person_id"
    t.integer "species_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["person_id"], name: "index_person_species_on_person_id"
    t.index ["species_id"], name: "index_person_species_on_species_id"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "species", force: :cascade do |t|
    t.string "name"
    t.integer "height_avg"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transports", force: :cascade do |t|
    t.string "name"
    t.string "type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
