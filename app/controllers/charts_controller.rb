class ChartsController < ApplicationController
  def settings
    # We generate a dynamic settings xml file for the amchart because we need
    # to specify a dynamic data file url in it
    @data_url = params[:data_url] || "/charts/random_data"
    render :layout => false
  end
  def random_data
    @data = IssueSection.chart_data
    render :layout => false
  end
end
