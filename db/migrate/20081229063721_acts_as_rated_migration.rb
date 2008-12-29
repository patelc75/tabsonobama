class ActsAsRatedMigration < ActiveRecord::Migration
  def self.up
    #ActiveRecord::Base.create_ratings_table
    #ActiveRecord::Base.create_ratings_table :with_rater => false, :table_name => 'no_rater_ratings'
    #ActiveRecord::Base.create_ratings_table :with_stats_table => true, :table_name => 'stats_ratings' 
    ActiveRecord::Base.create_ratings_table :with_stats_table => true, :stats_table_name => 'statistics'
    
    IssueGroup.add_ratings_columns
    IssueSection.add_ratings_columns
    IssueBullet.add_ratings_columns
    
    remove_column :issue_groups, :rating
    remove_column :issue_groups, :ratings_count
    remove_column :issue_sections, :rating
    remove_column :issue_sections, :ratings_count
    remove_column :issue_bullets, :rating
    remove_column :issue_bullets, :ratings_count    
  end
  
  def self.down
    IssueGroup.remove_ratings_columns
    IssueSection.remove_ratings_columns
    IssueBullet.remove_ratings_columns
    
    add_column :issue_groups, :rating, :float
    add_column :issue_groups, :ratings_count, :integer
    add_column :issue_sections, :rating, :float
    add_column :issue_sections, :ratings_count, :integer
    add_column :issue_bullets, :rating, :float
    add_column :issue_bullets, :ratings_count, :integer 
    
    #ActiveRecord::Base.drop_ratings_table
    #ActiveRecord::Base.drop_ratings_table :table_name => 'no_rater_ratings'
    #ActiveRecord::Base.drop_ratings_table :with_stats_table => true, :table_name => 'stats_ratings'                                 
    ActiveRecord::Base.drop_ratings_table :with_stats_table => true, :stats_table_name => 'statistics'
  end
end
