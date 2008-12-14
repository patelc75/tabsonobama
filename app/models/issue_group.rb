class IssueGroup < ActiveRecord::Base
  acts_as_rateable
  has_permalink :name
end
