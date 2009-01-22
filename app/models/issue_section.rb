class IssueSection < ActiveRecord::Base
  acts_as_rated
  include Chartable
  
  belongs_to :issue_group
  has_many :issue_bullets
  
  has_permalink :name
  def to_param
    self.permalink
  end
end