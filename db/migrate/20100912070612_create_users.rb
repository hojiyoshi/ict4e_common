class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table "users", :force => true do |t|
      t.string   :email,                    :limit => 100
      t.string   :crypted_password,         :limit => 40
      t.string   :salt,                     :limit => 40
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :remember_token,           :limit => 40
      t.datetime :remember_token_expires_at
      t.string   :activation_code,          :limit => 40
      t.datetime :activated_at
      t.string   :uid,                      :limit => 100, :null => true
      t.string   :user_type,                :limit => 1,   :default => 'w'
    end
    add_index :users, :uid, :unique => true
  end

  def self.down
    drop_table "users"
  end
end