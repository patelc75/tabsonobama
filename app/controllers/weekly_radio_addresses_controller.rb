class WeeklyRadioAddressesController < ApplicationController
  
  def index
    @addresses = WeeklyRadioAddress.find(:all, :order => "timestamp DESC")
  end
  
  def show
    @address = WeeklyRadioAddress.find_by_permalink(params[:id])
  end
  
end