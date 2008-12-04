class AddPermalinkToIssueSections < ActiveRecord::Migration
  def self.up
    add_column :issue_sections, :permalink, :string
  end

  def self.down
    remove_column :issue_sections, :permalink
  end
end
