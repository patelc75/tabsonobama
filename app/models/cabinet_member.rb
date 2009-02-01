class CabinetMember < ActiveRecord::Base
  acts_as_rated

  include Promotable
  has_one :promotion, :as => :item, :dependent => :destroy
  
  has_permalink :nominee
  def to_param
    self.permalink
  end
  
  def self.featured
    promotion = Promotion.home_page.cabinet_member.first
    return promotion.item if promotion
    return find(:first, :order => "rand()")
  end
end