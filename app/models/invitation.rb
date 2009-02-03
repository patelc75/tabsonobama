class Invitation < ActiveRecord::Base
  
  belongs_to :sender, :class_name => "User"
  has_one :recipient, :class_name => "User"
  
  validates_presence_of :recipient_email
  validate :recipient_is_not_registered
  validate :sender_has_invitations
  
  before_create :generate_token
  before_create :decrement_sender_count
  
private
  def recipient_is_not_registered
    errors.add :recipient_email, "is already registered" if User.find_by_email(recipient_email)
  end
  
  def sender_has_invitations
    if sender
      errors.add_to_base "You're all out of invitations." unless sender.has_invitations?
    end
  end
  
  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end
  
  def decrement_sender_count
    if sender
      self.sender.decrement! :invitation_limit
    end
  end
  
end