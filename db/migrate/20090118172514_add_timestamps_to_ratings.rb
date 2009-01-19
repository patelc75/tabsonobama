class AddTimestampsToRatings < ActiveRecord::Migration
  def self.up
    add_column :ratings, :created_at, :datetime
    add_column :ratings, :updated_at, :datetime
  end

  def self.down
    remove_column :ratings, :updated_at
    remove_column :ratings, :created_at
  end
end
