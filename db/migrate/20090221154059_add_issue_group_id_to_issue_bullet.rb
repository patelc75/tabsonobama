class AddIssueGroupIdToIssueBullet < ActiveRecord::Migration
  def self.up
    add_column :issue_bullets, :issue_group_id, :integer
  end

  def self.down
  	remove_column :issue_bullets, :issue_group_id
  end
end
