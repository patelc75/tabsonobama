class AddPermalinkToWeeklyRadioAddresses < ActiveRecord::Migration
  
  def self.up
    add_column :weekly_radio_addresses, :permalink, :string
  end
  
  def self.down
    remove_column :weekly_radio_addresses, :permalink
  end
  
end