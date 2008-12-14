class RemoveRatingsTable < ActiveRecord::Migration
  def self.up
    drop_table :ratings
  end

  def self.down
    create_table :ratings do |t|
      t.integer :user_id
      t.float :rating
      t.string :issue_type
      t.integer :issue_id

      t.timestamps
    end
  end
end
