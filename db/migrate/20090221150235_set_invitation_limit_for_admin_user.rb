class SetInvitationLimitForAdminUser < ActiveRecord::Migration
  def self.up
    u = User.find_by_login('admin')
    u.invitation_limit = 5000
    u.save
  end

  def self.down
  	u = User.find_by_login('admin')
    u.invitation_limit = 0
    u.save
  end
end
