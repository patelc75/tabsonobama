require 'digest/sha1'

class User < ActiveRecord::Base
  concerned_with :authentication, :authorization
  
  has_many :ratings
  has_one :profile
end
