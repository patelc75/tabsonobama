require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invitation do

  before(:each) do
    @valid_attributes = {
      :sender_id => 1,
      :recipient_email => "value for recipient_email",
      :token => "value for token",
      :sent_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Invitation.create!(@valid_attributes)
  end

end