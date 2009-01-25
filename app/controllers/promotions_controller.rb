class PromotionsController < ApplicationController
  before_filter :login_and_admin_required
  
  def create
    item = params[:item_type].constantize.find_by_id(params[:item_id])
    item.promote!({}, current_user)
    
    render :partial => "promote", :locals => {:item => item}
  end
  
  def destroy
    promotion = Promotion.find_by_id(params[:id])
    promotion.destroy

    render :partial => "promote"
  end
  
  private
  def login_and_admin_required
    logged_in? && current_user.is_admin?
  end
end
