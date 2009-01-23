require 'digest/sha1'

class User < ActiveRecord::Base
  concerned_with :authentication, :authorization
  
  has_many :ratings
  has_one :profile, :dependent => :destroy
  
  validates_associated :profile
  
  attr_accessible :new_profile_attributes, :updated_roles
  def new_profile_attributes=(profile_attributes)
    self.build_profile(profile_attributes)
  end
  
  def updated_roles=(role_hash)
    role_ids = role_hash.empty? ? [] : role_hash.keys.collect(&:to_i)
    self.update_roles(role_ids)
  end
  
  def update_roles(role_ids)
    # add new roles
    role_ids.each do |id|
      role = Role.find(id)
      self.roles << role unless self.roles.include?(role)
    end
    # remove stale roles
    roles.each do |role|
      self.roles.delete(role) unless role_ids.include?(role.id)
    end
  end
end