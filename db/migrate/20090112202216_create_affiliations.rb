class CreateAffiliations < ActiveRecord::Migration
  def self.up
    create_table :affiliations do |t|
      t.string :name
      t.timestamps
    end
    
    %w{ Democrat Republican Independent }.each { |a| Affiliation.create(:name => a) }
  end
  
  def self.down
    drop_table :affiliations
  end
end
