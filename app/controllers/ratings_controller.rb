class RatingsController < ApplicationController
  before_filter :get_class_by_name
    
  def rate
    return unless logged_in?
    
    rateable = @rateable_class.find(params[:id])
    
    # Delete the old ratings for current user
    Rating.delete_all(["rated_type = ? AND rated_id = ? AND rater_id = ?", @rateable_class.base_class.to_s, params[:id], @current_user.id])
    rateable.rate params[:rating].to_f, @current_user
        
    render :update do |page|
      page.replace_html "star-ratings-block-#{rateable.id}", :partial => "rate", :locals => { :asset => rateable }
      page.visual_effect :highlight, "star-ratings-block-#{rateable.id}"
    end
        
  end
  
  protected
  
  # Gets the rateable class based on the params[:rateable_type]
  def get_class_by_name
    bad_class = false
    begin
      @rateable_class = Module.const_get(params[:rated_type])
    rescue NameError
      # The user is messing with the content_class...
      bad_class = true
    end 
    
    # This means the user is doing something funky...naughty naughty...
    if bad_class
      redirect_to home_url
      return false
    end
    
    true
  end
end