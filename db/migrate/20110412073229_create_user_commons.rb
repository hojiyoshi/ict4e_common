class CreateUserCommons < ActiveRecord::Migration
  def self.up
    create_table "user_commons", :force => true do |t|
      t.column "name_kanji",        :string,  :limit => 64
      t.column "name_kana",         :string,  :limit => 64
      t.column "phone_number",      :string,  :limit => 8
      t.column "fax_number",        :string,  :limit => 8
      t.column "cellphone_number",  :string,  :limit => 8
      t.column "cellphone_email",   :string
      t.column "zip_code",          :string,  :limit =>8
      t.column "user_address1",     :string
      t.column "user_address2",     :string
      t.column "user_id",           :integer, :null => false
      t.column "skype_id",          :string
    end
    add_index :user_commons, :user_id, :unique => true
  end

  def self.down
    drop_table "user_commons"
  end
end