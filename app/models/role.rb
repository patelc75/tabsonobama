class Role < ActiveRecord::Base
  def self.admin_role
    Role.find_by_name("admin")
  end
  def self.super_admin_role
    Role.find_by_name("super_admin")
  end
end