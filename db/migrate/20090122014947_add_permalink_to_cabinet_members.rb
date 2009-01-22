class AddPermalinkToCabinetMembers < ActiveRecord::Migration
  
  def self.up
    add_column :cabinet_members, :permalink, :string
  end
  
  def self.down
    remove_column :cabinet_members, :permalink
  end
  
end