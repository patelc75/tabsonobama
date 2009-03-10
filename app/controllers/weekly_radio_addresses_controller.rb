class WeeklyRadioAddressesController < ApplicationController
  
  def index
    @addresses = WeeklyRadioAddress.find(:all, :order => "timestamp DESC")
  end
  
  def show
    @address = WeeklyRadioAddress.find_by_permalink(params[:id])
  end
  
  def new
    @weekly = WeeklyRadioAddress.new
  end

  def create
    @weekly = WeeklyRadioAddress.new(params[:weekly_radio_address])
    if @weekly.save
      flash[:notice] = 'Weekly Radio Address created.'
      redirect_to("/weekly-radio-addresses/#{@weekly.permalink}")
    else
      render :action => "new"
    end
  end
  
  def delete
  	@address = WeeklyRadioAddress.find_by_permalink(params[:id])
  	if @address.delete
  	  flash[:notice] = 'Weekly Radio Address deleted.'
      redirect_to :controller => "weekly-radio-addresses", :action => "index"	
  	end
  end
end