require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper')

describe "/issue_bullets/index" do
  before(:each) do
    render 'issue_bullets/index'
  end
  
  #Delete this example and add some real ones or delete this file
  it "should tell you where to find the file" do
    response.should have_tag('p', %r[Find me in app/views/issue_bullets/index])
  end
end
