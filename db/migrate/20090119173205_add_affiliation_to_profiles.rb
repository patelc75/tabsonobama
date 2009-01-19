class AddAffiliationToProfiles < ActiveRecord::Migration
  
  def self.up
    add_column :profiles, :affiliation_id, :integer
  end
  
  def self.down
    remove_column :profiles, :affiliation_id
  end
  
end
