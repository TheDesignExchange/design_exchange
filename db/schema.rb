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

ActiveRecord::Schema.define(:version => 20131003225343) do

  create_table "categorizations", :force => true do |t|
    t.integer  "design_method_id"
    t.integer  "method_category_id"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  add_index "categorizations", ["design_method_id", "method_category_id"], :name => "cat_index", :unique => true
  add_index "categorizations", ["design_method_id"], :name => "index_categorizations_on_design_method_id"
  add_index "categorizations", ["method_category_id"], :name => "index_categorizations_on_method_category_id"

  create_table "citations", :force => true do |t|
    t.string   "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

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

  create_table "method_citations", :force => true do |t|
    t.integer  "design_method_id"
    t.integer  "citation_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "method_citations", ["citation_id"], :name => "index_method_citations_on_citation_id"
  add_index "method_citations", ["design_method_id", "citation_id"], :name => "index_method_citations_on_design_method_id_and_citation_id", :unique => true
  add_index "method_citations", ["design_method_id"], :name => "index_method_citations_on_design_method_id"

  create_table "user_sessions", :force => true do |t|
    t.string   "user_session_id", :null => false
    t.text     "data"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "user_sessions", ["updated_at"], :name => "index_user_sessions_on_updated_at"
  add_index "user_sessions", ["user_session_id"], :name => "index_user_sessions_on_user_session_id"

  create_table "users", :force => true do |t|
    t.string   "login",             :null => false
    t.string   "crypted_password",  :null => false
    t.string   "password_salt",     :null => false
    t.string   "persistence_token", :null => false
    t.string   "name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
