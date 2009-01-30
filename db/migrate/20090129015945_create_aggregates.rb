class CreateAggregates < ActiveRecord::Migration
  def self.up  	
    create_table :aggregates do |t|
	  t.string :rateable_type
      t.timestamps
    end
    
    Aggregate.add_ratings_columns
    
    Aggregate.create :rateable_type => WeeklyRadioAddress.class_name
    Aggregate.create :rateable_type => CabinetMember.class_name
    Aggregate.create :rateable_type => IssueGroup.class_name
  end
  
  def self.down
    drop_table :aggregates
  end
end