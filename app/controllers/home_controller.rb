class HomeController < ApplicationController
  
  def index
    @user = User.new
    @profile = @user.build_profile
  end
  
end