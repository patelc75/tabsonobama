class CreateRatings < ActiveRecord::Migration
  def self.up
    create_table :ratings do |t|
      t.integer :user_id
      t.float :rating
      t.string :issue_type
      t.integer :issue_id

      t.timestamps
    end
  end

  def self.down
    drop_table :ratings
  end
end
