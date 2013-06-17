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

ActiveRecord::Schema.define(:version => 20130617071949) do

  create_table "activities", :force => true do |t|
    t.string   "name"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.string   "pic"
    t.string   "keyword"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "audios", :force => true do |t|
    t.string   "uuid"
    t.string   "title"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.text     "description"
  end

  create_table "coupons", :force => true do |t|
    t.integer  "weixin_user_id"
    t.string   "sn_code"
    t.string   "status"
    t.datetime "expired_at"
    t.datetime "used_at"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "events", :force => true do |t|
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "category"
    t.string   "title"
    t.string   "description"
    t.string   "pic_uuid"
    t.string   "url"
    t.integer  "max_random"
    t.integer  "max_luck"
  end

  create_table "hd_scratch_cards", :force => true do |t|
    t.integer  "weixin_user_id"
    t.string   "sn_code"
    t.string   "status"
    t.datetime "used_at"
    t.string   "prize"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "event_id"
  end

  create_table "items", :force => true do |t|
    t.integer  "news_id"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "pic"
    t.string   "pic_uuid"
  end

  create_table "keyword_replies", :force => true do |t|
    t.string   "keyword"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "kindeditor_assets", :force => true do |t|
    t.string   "asset"
    t.integer  "file_size"
    t.string   "file_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "news", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "pic"
    t.string   "pic_uuid"
  end

  create_table "ownerships", :force => true do |t|
    t.integer  "user_id"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "pictures", :force => true do |t|
    t.string   "pic_uuid"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "qa_steps", :force => true do |t|
    t.string   "keyword"
    t.text     "question"
    t.integer  "priority"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "replies", :force => true do |t|
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "target_id"
    t.string   "target_type"
  end

  create_table "reply_texts", :force => true do |t|
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "request_messages", :force => true do |t|
    t.text     "xml"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "msg_type"
    t.integer  "weixin_user_id"
  end

  create_table "response_messages", :force => true do |t|
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "weixin_user_id"
    t.integer  "request_message_id"
  end

  create_table "settings", :force => true do |t|
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "weixin_id"
    t.string   "token"
    t.text     "welcome_message"
    t.text     "default_message"
    t.integer  "user_id"
    t.string   "account"
    t.string   "password"
  end

  add_index "settings", ["weixin_id"], :name => "index_settings_on_weixin_id", :unique => true

  create_table "shops", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "phone_number"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "region"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geocoding_address"
  end

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       :limit => 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "videos", :force => true do |t|
    t.string   "uuid"
    t.string   "title"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "weixin_users", :force => true do |t|
    t.string   "open_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "weixin_id"
    t.boolean  "sex"
    t.string   "age"
    t.string   "scale"
    t.string   "geocoding_address"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "name"
    t.string   "avatar"
  end

  create_table "wx_events", :force => true do |t|
    t.integer  "weixin_user_id"
    t.string   "event"
    t.string   "event_key"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "request_message_id"
  end

  create_table "wx_images", :force => true do |t|
    t.integer  "weixin_user_id"
    t.string   "pic_url"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "request_message_id"
  end

  create_table "wx_links", :force => true do |t|
    t.integer  "weixin_user_id"
    t.string   "title"
    t.text     "description"
    t.string   "url"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "request_message_id"
  end

  create_table "wx_locations", :force => true do |t|
    t.integer  "weixin_user_id"
    t.integer  "scale"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "request_message_id"
    t.float    "latitude"
    t.float    "longitude"
    t.string   "geocoding_address"
  end

  create_table "wx_texts", :force => true do |t|
    t.integer  "weixin_user_id"
    t.string   "content"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.integer  "request_message_id"
  end

end
