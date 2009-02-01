require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Invitation do
  fixtures :users

  before(:each) do
    @default_user = create_user
    @valid_attributes = {
      :sender => @default_user,
      :recipient_email => "value for recipient_email",
      :sent_at => Time.now
    }
  end

  it "should create a new instance given valid attributes" do
    Invitation.create!(@valid_attributes)
  end
  
  describe 'validations' do
    
    it "should require recipient email" do
      @valid_attributes.delete(:recipient_email)
      invalid = Invitation.new(@valid_attributes)
      invalid.should_not be_valid
      invalid.should have(1).error_on(:recipient_email)
    end
    
    it "should ensure recipient isn't already registered" do
      @default_user.has_invitations?.should be_true
      aaron = users(:aaron)
      @valid_attributes[:recipient_email] = aaron.email
      invalid = Invitation.create(@valid_attributes)
      invalid.should_not be_valid
      invalid.should have(1).error_on(:recipient_email)
    end
    
    it "should ensure sender has invitations" do
      @default_user.invitation_limit = 0
      @default_user.has_invitations?.should be_false
      invalid = Invitation.create(@valid_attributes)
      invalid.should_not be_valid
      invalid.should have(1).error_on(:base)
    end

  end
  
  describe 'creation' do
  
    it 'should generate a token' do
      invitation = Invitation.create(@valid_attributes)
      invitation.token.should_not be_nil
    end

    it "should decrement sender's invitation limit" do
      @default_user.invitation_limit.should == 5
      Invitation.create(@valid_attributes)
      @default_user.invitation_limit.should == 4
    end
  
  end

end