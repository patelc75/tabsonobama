require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe InvitationsController do
  describe "route generation" do
    it "should map #index" do
      route_for(:controller => "invitations", :action => "index").should == "/invitations"
    end
  
    it "should map #new" do
      route_for(:controller => "invitations", :action => "new").should == "/invitations/new"
    end
  
    it "should map #show" do
      route_for(:controller => "invitations", :action => "show", :id => 1).should == "/invitations/1"
    end
  
    it "should map #edit" do
      route_for(:controller => "invitations", :action => "edit", :id => 1).should == "/invitations/1/edit"
    end
  
    it "should map #update" do
      route_for(:controller => "invitations", :action => "update", :id => 1).should == "/invitations/1"
    end
  
    it "should map #destroy" do
      route_for(:controller => "invitations", :action => "destroy", :id => 1).should == "/invitations/1"
    end
  end

  describe "route recognition" do
    it "should generate params for #index" do
      params_from(:get, "/invitations").should == {:controller => "invitations", :action => "index"}
    end
  
    it "should generate params for #new" do
      params_from(:get, "/invitations/new").should == {:controller => "invitations", :action => "new"}
    end
  
    it "should generate params for #create" do
      params_from(:post, "/invitations").should == {:controller => "invitations", :action => "create"}
    end
  
    it "should generate params for #show" do
      params_from(:get, "/invitations/1").should == {:controller => "invitations", :action => "show", :id => "1"}
    end
  
    it "should generate params for #edit" do
      params_from(:get, "/invitations/1/edit").should == {:controller => "invitations", :action => "edit", :id => "1"}
    end
  
    it "should generate params for #update" do
      params_from(:put, "/invitations/1").should == {:controller => "invitations", :action => "update", :id => "1"}
    end
  
    it "should generate params for #destroy" do
      params_from(:delete, "/invitations/1").should == {:controller => "invitations", :action => "destroy", :id => "1"}
    end
  end
end
