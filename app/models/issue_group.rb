class IssueGroup < ActiveRecord::Base
  acts_as_rated
  has_permalink :name
  
  has_many :issue_sections
end