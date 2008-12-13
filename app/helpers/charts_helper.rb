module ChartsHelper
  def chart(data_url=nil)
    render :partial => "/charts/chart", :locals => {:data_url => data_url}
  end
end
