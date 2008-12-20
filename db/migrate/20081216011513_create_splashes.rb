class CreateSplashes < ActiveRecord::Migration
  def self.up
    create_table :splashes do |t|
      t.string :email

      t.timestamps
    end
  end

  def self.down
    drop_table :splashes
  end
end
