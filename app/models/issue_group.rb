class IssueGroup < ActiveRecord::Base
  acts_as_rated
  has_many :issue_sections

  include Promotable
  has_one :promotion, :as => :item, :dependent => :destroy
  
  has_permalink :name
  def to_param
    self.permalink
  end
  
  # returns an array
  def self.featured
    promotions = Promotion.home_page.issue_group.collect{|promotion| promotion.item}
    return promotions unless promotions.empty?
    return find(:all, :order => "rand()", :limit => 3)
  end
  
end