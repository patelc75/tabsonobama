class AddPermalinkToIssueGroup < ActiveRecord::Migration
  def self.up
    add_column :issue_groups, :permalink, :string
  end

  def self.down
    remove_column :issue_groups, :permalink
  end
end
