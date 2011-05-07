class IssueBullet < ActiveRecord::Base
  acts_as_rated
  belongs_to :issue_section
  belongs_to :issue_group

  include Promotable
  has_one :promotion, :as => :item, :dependent => :destroy

  has_permalink :short
  def to_param
    self.permalink
  end
  
  # returns an array
  def self.featured
    promotions = Promotion.home_page.issue_bullet.collect{|promotion| promotion.item}
    return promotions unless promotions.empty?
    return find(:all, :order => "rand()", :limit => 1)
  end
end