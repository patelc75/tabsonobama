class AddPhotoFilenameToCabinetMembers < ActiveRecord::Migration
  def self.up
    add_column :cabinet_members, :photo_filename, :string
    remove_column :weekly_radio_addresses, :weekly_radio_address_id
  end
  
  def self.down
    remove_column :cabinet_members, :photo_filename
    add_column :weekly_radio_addresses, :weekly_radio_address_id, :integer
  end
end
