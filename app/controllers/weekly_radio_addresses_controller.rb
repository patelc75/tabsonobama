class WeeklyRadioAddressesController < ApplicationController
  
  def index
    @addresses = WeeklyRadioAddress.find(:all)
  end
  
  def show
    @address = WeeklyRadioAddress.find_by_permalink(params[:id])
  end
  
end