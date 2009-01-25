class Role < ActiveRecord::Base
  def self.admin_role
    Role.find_by_name("admin")
  end
end