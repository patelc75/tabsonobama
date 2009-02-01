class Invitation < ActiveRecord::Base
  validates_presence_of :sender_id, :recipient_email, :token
end