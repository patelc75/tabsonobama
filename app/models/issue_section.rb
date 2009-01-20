class IssueSection < ActiveRecord::Base
  acts_as_rated
  include Chartable
  
  belongs_to :issue_group
  has_many :issue_bullets
  has_permalink :name
end
