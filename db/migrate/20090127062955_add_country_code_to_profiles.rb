class AddCountryCodeToProfiles < ActiveRecord::Migration
  
  def self.up
    add_column :profiles, :country_code, :integer
  end
  
  def self.down
    remove_column :profiles, :country_code
  end
  
end