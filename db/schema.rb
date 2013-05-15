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

ActiveRecord::Schema.define(:version => 20130515071330) do

  create_table "events", :force => true do |t|
    t.integer  "weixin_user_id"
    t.string   "event"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "keyword_replies", :force => true do |t|
    t.string   "keyword"
    t.text     "reply_content"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "qa_steps", :force => true do |t|
    t.string   "keyword"
    t.text     "question"
    t.integer  "priority"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "request_messages", :force => true do |t|
    t.text     "xml"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "response_messages", :force => true do |t|
    t.text     "content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "weixin_user_id"
  end

  create_table "weixin_users", :force => true do |t|
    t.string   "open_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "weixin_id"
    t.boolean  "sex"
    t.string   "age"
    t.string   "location_x"
    t.string   "location_y"
    t.string   "scale"
  end

  create_table "wx_locations", :force => true do |t|
    t.integer  "weixin_user_id"
    t.string   "location_x"
    t.string   "location_y"
    t.integer  "scale"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "wx_texts", :force => true do |t|
    t.integer  "weixin_user_id"
    t.string   "content"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
