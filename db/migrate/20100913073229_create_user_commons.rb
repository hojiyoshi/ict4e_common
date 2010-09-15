class CreateUserCommons < ActiveRecord::Migration
  def self.up
    create_table "user_commons", :force => true do |t|
      t.column "lastname_kanji",    :string,  :limit => 64
      t.column "lastname_kana",     :string,  :limit => 64
      t.column "firstname_kanji",   :string,  :limit => 64
      t.column "firstname_kana",    :string,  :limit => 64
      t.column "phone_number1",     :string,  :limit => 8
      t.column "phone_number2",     :string,  :limit => 8
      t.column "phone_number3",     :string,  :limit => 8
      t.column "fax_number1",       :string,  :limit => 8
      t.column "fax_number2",       :string,  :limit => 8
      t.column "fax_number3",       :string,  :limit => 8
      t.column "cellphone_number1", :string,  :limit => 8
      t.column "cellphone_number2", :string,  :limit => 8
      t.column "cellphone_number3", :string,  :limit => 8
      t.column "cellphone_email",   :string
      t.column "user_address1",     :string,  :limit => 16
      t.column "user_address2",     :string,  :limit => 25
      t.column "user_address3",     :string
      t.column "user_address4",     :string
      t.column "user_address5",     :string
      t.column "user_id",           :integer, :null => false
      t.column "skype_id",          :string,  :limit => 255
    end
    add_index :user_commons, :user_id, :unique => true
  end

  def self.down
    drop_table "user_commons"
  end
end