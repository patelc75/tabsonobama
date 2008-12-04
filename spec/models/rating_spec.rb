require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Rating do
  before(:each) do
    @valid_attributes = {
    }
  end

  it "should create a new instance given valid attributes" do
    Rating.create!(@valid_attributes)
  end
end
