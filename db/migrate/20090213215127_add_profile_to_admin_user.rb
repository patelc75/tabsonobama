class AddProfileToAdminUser < ActiveRecord::Migration
  def self.up
  	u = User.find_by_login('admin')
  	p = Profile.new(:first_name => 'Chester', :last_name => 'Obama', :zip => '11211', :country_code=>1)
  	u.profile = p
  	p.save
  	u.save
  end

  def self.down
  	u.profile = nil
  end
end
