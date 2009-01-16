class RemoveNameFromProfiles < ActiveRecord::Migration
  
  def self.up
    remove_column :profiles, :name
  end
  
  def self.down
    add_column :profiles, :name, :string
  end
  
end