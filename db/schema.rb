# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110412073229) do

  create_table "ict4e_master_data", :force => true do |t|
    t.string  "application_name", :limit => 64, :null => false
    t.string  "item_data",        :limit => 64, :null => false
    t.integer "sort_order",                     :null => false
  end

  add_index "ict4e_master_data", ["application_name"], :name => "application_name"

  create_table "summary_users", :force => true do |t|
    t.integer "user_id",                            :null => false
    t.integer "application_type",                   :null => false
    t.integer "phone_contact",                      :null => false
    t.string  "skype_id"
    t.integer "inputer_flag",        :default => 0, :null => false
    t.integer "cordinater_flag",     :default => 0, :null => false
    t.integer "user_flag",           :default => 0, :null => false
    t.integer "network_env"
    t.text    "network_env_other"
    t.integer "input_career"
    t.text    "input_career_other"
    t.integer "input_speed"
    t.text    "input_speed_other"
    t.text    "join_day_other"
    t.text    "join_time_other"
    t.text    "like_field_other"
    t.text    "dislike_field_other"
    t.text    "qualification_data"
    t.integer "inputer_status",      :default => 0
  end

  add_index "summary_users", ["user_id"], :name => "summary_users_user_id_key", :unique => true

  create_table "tenji_autodeletes", :force => true do |t|
    t.string "days"
  end

  create_table "tenji_requests", :force => true do |t|
    t.string   "from_zip_code",         :limit => 64, :null => false
    t.string   "from_user_name",        :limit => 64, :null => false
    t.string   "from_user_affiliation", :limit => 64
    t.string   "from_phone_number",     :limit => 64
    t.string   "from_user_address1",                  :null => false
    t.string   "from_user_address2"
    t.string   "to_zip_code",           :limit => 64, :null => false
    t.string   "to_user_name",          :limit => 64, :null => false
    t.string   "to_user_address1",                    :null => false
    t.string   "to_user_address2"
    t.integer  "user_id",                             :null => false
    t.string   "print_name",                          :null => false
    t.string   "print_title1"
    t.string   "print_title2"
    t.string   "print_title3"
    t.text     "print_contents1"
    t.text     "print_contents2"
    t.text     "print_contents3"
    t.string   "braille_datafile"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "data_type",             :limit => 32, :null => false
  end

  create_table "tenji_users", :force => true do |t|
    t.integer  "user_id",                                         :null => false
    t.string   "tenji_type",       :limit => 1,  :default => "f", :null => false
    t.string   "zip_code",         :limit => 64
    t.string   "user_name",        :limit => 64
    t.string   "user_affiliation", :limit => 64
    t.string   "phone_number",     :limit => 64
    t.string   "user_address1"
    t.string   "user_address2"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_commons", :force => true do |t|
    t.string  "name_kanji",       :limit => 64
    t.string  "name_kana",        :limit => 64
    t.string  "phone_number",     :limit => 8
    t.string  "fax_number",       :limit => 8
    t.string  "cellphone_number", :limit => 8
    t.string  "cellphone_email"
    t.string  "zip_code",         :limit => 8
    t.string  "user_address1"
    t.string  "user_address2"
    t.integer "user_id",                        :null => false
    t.string  "skype_id"
  end

  add_index "user_commons", ["user_id"], :name => "index_user_commons_on_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.string   "activation_code",           :limit => 40
    t.datetime "activated_at"
    t.string   "uid",                       :limit => 100
    t.string   "user_type",                 :limit => 1,   :default => "w"
  end

  add_index "users", ["uid"], :name => "index_users_on_uid", :unique => true

end
