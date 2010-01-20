require 'digest/sha1'

class Password < ActiveRecord::Base
  attr_accessor :email
  
  belongs_to :user
  
  validates_presence_of :user, :message => "with that email address doesn't exist."
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => 'is not a valid email address'

  protected  
    def before_create
      self.reset_code = Digest::SHA1.hexdigest(Time.now.to_s.split(//).sort_by {rand}.join )
      self.expiration_date = 2.weeks.from_now
    end
end