class ChangeWeeklyRadioDateTimeToDate < ActiveRecord::Migration
  def self.up
    change_column :weekly_radio_addresses, :timestamp, :date
  end

  def self.down
    change_column :weekly_radio_addresses, :date, :timestamp
  end
end