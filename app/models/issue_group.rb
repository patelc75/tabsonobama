class IssueGroup < ActiveRecord::Base
  acts_as_rated
  has_permalink :name
end
