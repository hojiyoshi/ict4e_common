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

ActiveRecord::Schema.define(:version => 20100913073229) do

  create_table "user_commons", :force => true do |t|
    t.string  "lastname_kanji",    :limit => 64
    t.string  "lastname_kana",     :limit => 64
    t.string  "firstname_kanji",   :limit => 64
    t.string  "firstname_kana",    :limit => 64
    t.string  "phone_number1",     :limit => 8
    t.string  "phone_number2",     :limit => 8
    t.string  "phone_number3",     :limit => 8
    t.string  "fax_number1",       :limit => 8
    t.string  "fax_number2",       :limit => 8
    t.string  "fax_number3",       :limit => 8
    t.string  "cellphone_number1", :limit => 8
    t.string  "cellphone_number2", :limit => 8
    t.string  "cellphone_number3", :limit => 8
    t.string  "cellphone_email"
    t.string  "user_address1",     :limit => 16
    t.string  "user_address2",     :limit => 25
    t.string  "user_address3"
    t.string  "user_address4"
    t.string  "user_address5"
    t.integer "user_id",                         :null => false
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
