class AddDescriptionToWeeklyRadioAddresses < ActiveRecord::Migration
  
  def self.up
    add_column :weekly_radio_addresses, :description, :string
  end
  
  def self.down
    remove_column :weekly_radio_addresses, :description
  end
end