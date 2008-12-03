class CreateIssueSections < ActiveRecord::Migration
  def self.up
    create_table :issue_sections do |t|
      t.integer :issue_group_id
      t.string :name
      t.text :description
      t.float :rating
      t.integer :ratings_count

      t.timestamps
    end
  end

  def self.down
    drop_table :issue_sections
  end
end
