#
# This module includes methods for extracting data from a model that we can 
# then use to graph using amcharts
#
module Chartable
  def self.included(klass)
    klass.extend ClassMethods
  end
  
  module ClassMethods

    # 
    # chart_data is an array of [<date>,<value>] tuples
    # Right now this method just creates random data
    # [TODO: Override chart_data in included modules to return real data]
    def chart_data(options={})
      defaults = {
        :start_date => DateTime.now - 10.days,
        :end_date   => DateTime.now
      }
      options.merge!(defaults)
      data = []
      (options[:start_date]..options[:end_date]).each do |day|
        data << [day.to_s(:amchart), rand(5)]
      end
      data
    end
  end
end