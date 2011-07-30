class AddCurrentIpToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :current_ip, :string
  end

  def self.down
    remove_column :users, :current_ip
  end
end
