class AddPermalinkToIssueBullets < ActiveRecord::Migration
  def self.up
    add_column :issue_bullets, :permalink, :string
  end

  def self.down
    remove_column :issue_bullets, :permalink
  end
end
