class CreateIct4eMasterData < ActiveRecord::Migration
  def self.up
    create_table :ict4e_master_data, :force => true do |t|
      t.column "application_name", :string,  :limit => 64, :null => false
      t.column "item_data",        :string,  :limit => 64, :null => false
      t.column "sort_order",       :integer,               :null => false
    end

    add_index :ict4e_master_data, ["application_name"], :name => "application_name"
  end

  def self.down
    remove_index "summary_select_items", :name => "application_name"
    drop_table :ict4e_master_data
  end
end
