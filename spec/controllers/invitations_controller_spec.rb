require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvitationsController do

  def mock_invitation(options={})
    stubs = {
      :sender= => true,
      :recipient_email => 'email',
      :token => 'abc',
      :update_attribute => true,
      :valid? => true
    }
    stubs.merge!(options)
    @mock_invitation ||= mock_model(Invitation, stubs)
  end
  
  describe "responding to GET new" do
  
    it "should expose a new invitation as @invitation" do
      Invitation.should_receive(:new).and_return(mock_invitation)
      get :new
      assigns[:invitation].should equal(mock_invitation)
    end

  end

  describe "responding to POST create" do

    describe "with valid params" do
      
      it "should expose a newly created invitation as @invitation" do
        Invitation.should_receive(:new).with({'these' => 'params'}).and_return(mock_invitation(:save => true))
        post :create, :invitation => {:these => 'params'}
        assigns(:invitation).should equal(mock_invitation)
      end

      it "should redirect to the created invitation" do
        Invitation.stub!(:new).and_return(mock_invitation(:save => true))
        post :create, :invitation => {}
        response.should redirect_to(root_url)
      end
      
    end
    
    describe "with invalid params" do

      it "should expose a newly created but unsaved invitation as @invitation" do
        Invitation.stub!(:new).with({'these' => 'params'}).and_return(mock_invitation(:save => false))
        post :create, :invitation => {:these => 'params'}
        assigns(:invitation).should equal(mock_invitation)
      end

      it "should re-render the 'new' template" do
        Invitation.stub!(:new).and_return(mock_invitation(:save => false))
        post :create, :invitation => {}
        response.should render_template('new')
      end
      
    end
    
  end

end
