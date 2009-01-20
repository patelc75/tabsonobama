class WeeklyRadioAddressesController < ApplicationController
  
  def index
    @addresses = WeeklyRadioAddress.find(:all)
  end
  
  def show
    @address = WeeklyRadioAddress.find(params[:id])
  end
  
end