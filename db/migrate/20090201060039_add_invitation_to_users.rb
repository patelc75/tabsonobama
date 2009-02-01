class AddInvitationToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :invitation_id, :integer
    add_column :users, :invitation_limit, :integer

    # Create default admin user
    user = User.create do |u|
      u.login = 'admin'
      u.password = u.password_confirmation = 'chester'
      u.email = APP_CONFIG[:admin_email]
    end
    # Activate user
    user.register!
    user.activate!
    # create a admin role, add it to admin user
    admin_role = Role.create(:name => 'admin')
    user.roles << admin_role
    # create a super_admin role, add it to admin user
    super_admin_role = Role.create(:name => 'super_admin')
    user.roles << super_admin_role
  end

  def self.down
    remove_column :users, :invitation_limit
    remove_column :users, :invitation_id
  end
end
