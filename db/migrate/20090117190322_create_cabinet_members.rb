class CreateCabinetMembers < ActiveRecord::Migration
  def self.up
    create_table :cabinet_members do |t|
      t.integer :cabinet_member_id
      t.string :department
      t.string :office
      t.string :nominee
      t.string :image_link, :limit=>1024
      t.string :wikipedia_link, :limit=>1024
      t.string :previous_political_office
      t.string :previous_political_office_link, :limit=>1024
      t.timestamps
    end
  end

  def self.down
    drop_table :cabinet_members
  end
end