class ChartsController < ApplicationController
  def settings
    # We generate a dynamic settings xml file for the amchart because we need
    # to specify a dynamic data file url in it
    @data_url = params[:data_url] || "/charts/random_data"
    render :layout => false
  end
  def random_data
    text = IssueSection.chart_data.map {|datum| datum.join(",")}.join("\n")
    render :text => text
  end
end
