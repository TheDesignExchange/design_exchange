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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130819021258) do

  create_table "categorizations", :force => true do |t|
    t.integer  "design_method_id"
    t.integer  "method_category_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "categorizations", ["design_method_id", "method_category_id"], :name => "cat_index", :unique => true
  add_index "categorizations", ["design_method_id"], :name => "index_categorizations_on_design_method_id"
  add_index "categorizations", ["method_category_id"], :name => "index_categorizations_on_method_category_id"

  create_table "design_methods", :force => true do |t|
    t.string   "name"
    t.text     "overview"
    t.text     "process"
    t.text     "principle"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "method_categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
