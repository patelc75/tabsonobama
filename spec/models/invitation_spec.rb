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
  
  describe 'validations' do
    
    [:sender_id, :recipient_email, :token].each do |attribute|
      it "should require #{attribute}" do
        @valid_attributes.delete(attribute)
        invalid = Invitation.create(@valid_attributes)
        invalid.should_not be_valid
        invalid.should have(1).error_on(attribute)
      end
    end

  end

end