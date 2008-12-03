class CreateIssueBullets < ActiveRecord::Migration
  def self.up
    create_table :issue_bullets do |t|
      t.integer :issue_section_id
      t.text :name
      t.text :description
      t.float :rating
      t.integer :ratings_count

      t.timestamps
    end
  end

  def self.down
    drop_table :issue_bullets
  end
end
