require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvitationsController do

  describe "route generation" do

    it "should map #new" do
      route_for(:controller => "invitations", :action => "new").should == "/invitations/new"
    end

  end

  describe "route recognition" do

    it "should generate params for #new" do
      params_from(:get, "/invitations/new").should == {:controller => "invitations", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/invitations").should == {:controller => "invitations", :action => "create"}
    end

  end

end
