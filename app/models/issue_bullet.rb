class IssueBullet < ActiveRecord::Base
  acts_as_rated
  belongs_to :issue_section

  include Promotable
  has_one :promotion, :as => :item, :dependent => :destroy
  
  has_permalink :short
  def to_param
    self.permalink
  end
end