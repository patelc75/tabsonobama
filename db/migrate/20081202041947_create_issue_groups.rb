class CreateIssueGroups < ActiveRecord::Migration
  def self.up
    create_table :issue_groups do |t|
      t.string :name
      t.text :description
      t.float :rating
      t.integer :ratings_count
      
      t.timestamps
    end
  end

  def self.down
    drop_table :issue_groups
  end
end
