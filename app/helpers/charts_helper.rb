module ChartsHelper
  def chart(data=nil)
    render :partial => "/charts/chart"
  end
end
