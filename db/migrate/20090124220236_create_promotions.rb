class CreatePromotions < ActiveRecord::Migration
  def self.up
    create_table :promotions do |t|
      t.integer :item_id, :null => false
      t.string :item_type, :null => false
      t.boolean :home_page
      t.boolean :index_page
      t.integer :promoter_id
      t.timestamps
    end
    
    add_index :promotions, [:item_id, :item_type]
  end

  def self.down
    drop_table :promotions
  end
end
