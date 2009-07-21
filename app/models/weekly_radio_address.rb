class WeeklyRadioAddress < ActiveRecord::Base
  acts_as_rated

  include Promotable
  has_one :promotion, :as => :item, :dependent => :destroy
  
  has_permalink :timestamp #, :to_param => self.permalink[0..10]   add strftime("%B %d, %Y") 
  def to_param
    self.permalink #[0..10]
  end
  
  def self.featured
    promotion = Promotion.home_page.weekly_radio_address.first
    return promotion.item if promotion
    return find(:first, :order => "created_at desc")
  end
end