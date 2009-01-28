class AddShortToIssueBullets < ActiveRecord::Migration
  def self.up
    add_column :issue_bullets, :short, :text
  end
  
  def self.down
    remove_column :issue_bullets, :text
  end
end
