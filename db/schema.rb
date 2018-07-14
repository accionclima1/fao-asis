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

ActiveRecord::Schema.define(version: 2018_07_13_221134) do

  create_table "images", force: :cascade do |t|
    t.datetime "image_date"
    t.string "main_class"
    t.string "period_type"
    t.integer "crop_type"
    t.string "sowing_type"
    t.string "pixel_type"
    t.string "full_path"
    t.integer "start_year"
    t.integer "end_year"
    t.integer "percentage"
    t.boolean "is_csc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crop_type"], name: "index_images_on_crop_type"
    t.index ["end_year"], name: "index_images_on_end_year"
    t.index ["full_path"], name: "index_images_on_full_path", unique: true
    t.index ["image_date"], name: "index_images_on_image_date"
    t.index ["main_class"], name: "index_images_on_main_class"
    t.index ["percentage"], name: "index_images_on_percentage"
    t.index ["period_type"], name: "index_images_on_period_type"
    t.index ["pixel_type"], name: "index_images_on_pixel_type"
    t.index ["sowing_type"], name: "index_images_on_sowing_type"
    t.index ["start_year"], name: "index_images_on_start_year"
  end

end
