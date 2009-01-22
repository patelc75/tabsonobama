class IssueGroup < ActiveRecord::Base
  acts_as_rated
  has_many :issue_sections
  
  has_permalink :name
  def to_param
    self.permalink
  end
end