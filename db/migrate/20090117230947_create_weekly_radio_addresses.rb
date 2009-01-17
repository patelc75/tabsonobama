class CreateWeeklyRadioAddresses < ActiveRecord::Migration
  def self.up
    create_table :weekly_radio_addresses do |t|
      t.integer :weekly_radio_address_id
      t.timestamp :timestamp
      t.string :youtube_link, :limit=>1024
      t.timestamps
    end
  end

  def self.down
    drop_table :weekly_radio_addresses
  end
end
