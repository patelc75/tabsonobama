namespace :util do
  desc "add new user passing in an email address"
  task :add_user => :environment do
  	if ENV['email'] == nil
	    puts "Usage rake util:add_user email='chirag@chirag.name'"
    else	
	    user = User.create do |u|
	      email = ENV['email']
	      u.login = ENV['email']
	      u.password = u.password_confirmation = ENV['password']
	      u.email = ENV['email']
	      u.invitation = Invitation.create!(:recipient_email => email)
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
	    
	    puts "Created user with following attributes"
	    puts "Login: " + u.login
	    puts "Email: " + u.email
	end
  end
end