class IssueBulletsController < ApplicationController
  make_resourceful do
    actions :all
    belongs_to :section
  end
  
  def current_object
    @current_object ||= current_model.find_by_permalink(params[:id])
  end
end
