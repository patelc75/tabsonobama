class WeeklyRadioAddress < ActiveRecord::Base
  acts_as_rated
  
  has_permalink :timestamp
  def to_param
    self.permalink
  end
end