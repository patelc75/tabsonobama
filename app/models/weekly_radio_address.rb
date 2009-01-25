class WeeklyRadioAddress < ActiveRecord::Base
  acts_as_rated

  include Promotable
  has_one :promotion, :as => :item, :dependent => :destroy
  
  has_permalink :timestamp
  def to_param
    self.permalink
  end
end