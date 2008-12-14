class IssueSection < ActiveRecord::Base
  acts_as_rateable
  include Chartable
  
  belongs_to :issue_group
  has_permalink :name
end
