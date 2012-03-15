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

ActiveRecord::Schema.define(:version => 20120315183240) do

  create_table "job_searches", :force => true do |t|
    t.integer  "user_id"
    t.string   "search_term"
    t.integer  "zipcode"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "positions", :force => true do |t|
    t.integer  "user_id",                                :null => false
    t.integer  "lead_search_id"
    t.string   "source"
    t.string   "name",                                   :null => false
    t.text     "details"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "pstatus",        :default => "to_apply", :null => false
    t.string   "company"
    t.text     "comments"
    t.text     "app_link"
    t.datetime "app_due_date"
    t.boolean  "starred",        :default => false,      :null => false
    t.string   "city"
    t.string   "state"
    t.string   "country"
    t.datetime "post_date"
  end

  add_index "positions", ["lead_search_id"], :name => "index_positions_on_lead_search_id"
  add_index "positions", ["user_id"], :name => "index_positions_on_user_id"

  create_table "related_emails", :force => true do |t|
    t.string   "guid",        :null => false
    t.integer  "position_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "password_digest"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
