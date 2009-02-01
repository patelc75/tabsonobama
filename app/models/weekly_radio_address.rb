class WeeklyRadioAddress < ActiveRecord::Base
  acts_as_rated

  include Promotable
  has_one :promotion, :as => :item, :dependent => :destroy
  
  has_permalink :timestamp
  def to_param
    self.permalink
  end
  
  def self.featured
    promotion = Promotion.home_page.weekly_radio_address.first
    return promotion.item if promotion
    return find(:first, :order => "rand()")
  end
end