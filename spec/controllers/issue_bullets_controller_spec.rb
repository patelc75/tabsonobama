require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe IssueBulletsController do

  #Delete these examples and add some real ones
  it "should use IssueBulletsController" do
    controller.should be_an_instance_of(IssueBulletsController)
  end


  describe "GET 'index'" do
    it "should be successful" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "should be successful" do
      get 'edit'
      response.should be_success
    end
  end
end
