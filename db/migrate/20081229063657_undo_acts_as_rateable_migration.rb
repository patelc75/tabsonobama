class UndoActsAsRateableMigration < ActiveRecord::Migration
  def self.up
    drop_table :ratings
    drop_table :rates
  end
  
  def self.down
    create_table :rates do |t|
      t.column :score, :integer
    end
    
    create_table :ratings do |t|
      t.column :user_id, :integer
      t.column :rate_id, :integer
      t.column :rateable_id, :integer
      t.column :rateable_type, :string, :limit => 32
      t.timestamps
    end
    
    add_index :ratings, :rate_id
    add_index :ratings, [:rateable_id, :rateable_type]
  end
end