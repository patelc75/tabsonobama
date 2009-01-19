class RemoveLocationFromProfiles < ActiveRecord::Migration
  
  def self.up
    remove_column :profiles, :location
  end
  
  def self.down
    add_column :profiles, :location, :string
  end
  
end