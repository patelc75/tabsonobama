require 'digest/sha1'

class User < ActiveRecord::Base
  concerned_with :authentication, :authorization
  
  has_many :ratings
  has_one :profile, :dependent => :destroy
  
  validates_associated :profile
  
  attr_accessible :new_profile_attributes
  def new_profile_attributes=(profile_attributes)
    self.build_profile(profile_attributes)
  end
end