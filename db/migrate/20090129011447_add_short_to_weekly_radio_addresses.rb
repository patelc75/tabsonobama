class AddShortToWeeklyRadioAddresses < ActiveRecord::Migration
  def self.up
    add_column :weekly_radio_addresses, :short, :text
  end
  
  def self.down
    remove_column :weekly_radio_addresses, :text
  end
end
