require 'digest/sha1'

class User < ActiveRecord::Base
  concerned_with :authentication, :authorization
  
  has_many :ratings
  has_one :profile, :dependent => :destroy

  has_many :sent_invitations, :class_name => "Invitation", :foreign_key => "sender_id"
  belongs_to :invitation
  before_validation_on_create :set_invitation_limit
  
  validates_presence_of :invitation, :message => ' is required'
  validates_uniqueness_of :invitation_id, :message => " must be unique", :allow_nil => true
  
  validates_associated :profile
  
  attr_accessible :new_profile_attributes, :updated_roles, :invitation_token, :invitation
  
  def is_admin?
    roles.include?(Role.admin_role)
  end
  
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
  
  def has_invitations?
    self.invitation_limit > 0
  end
  
  def invitation_token
    self.invitation.token if invitation
  end
  
  def invitation_token=(token)
    self.invitation = Invitation.find_by_token(token)
  end
  
private
  def set_invitation_limit
    self.invitation_limit = 5
  end
end