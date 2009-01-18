class RatingsController < ApplicationController
  before_filter :get_class_by_name
    
  def rate
    
    rateable = @rateable_class.find(params[:id])
    
    if logged_in?
      # Delete the old ratings for current user
      # Rating.delete_all(["rated_type = ? AND rated_id = ? AND rater_id = ?", @rateable_class.base_class.to_s, params[:id], @current_user.id])
      rating = Rating.find(:first, 
                           :conditions => "rated_type = '#{@rateable_class.base_class.to_s}' AND rated_id = #{params[:id]} AND rater_id = #{current_user.id}", 
                           :order => 'updated_at desc')
      if !rating || (rating.updated_at.nil? || (rating.updated_at + 1.day) < Time.now)
        rateable.rate params[:rating].to_f, @current_user
      else
        #show warning popup
      end
    end
    render :update do |page|
      page.replace_html "star-ratings-block-#{rateable.class.to_s}-#{rateable.id}", :partial => "rate", :locals => { :asset => rateable }
      page.visual_effect :highlight, "star-ratings-block-#{rateable.class.to_s}-#{rateable.id}"
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