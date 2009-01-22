class IssueBullet < ActiveRecord::Base
  acts_as_rated
  belongs_to :issue_section
  
  has_permalink :name
  def to_param
    self.permalink
  end
end