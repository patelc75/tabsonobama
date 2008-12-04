class IssueGroup < ActiveRecord::Base
  has_many :ratings, :as => :issue
  has_many :raters, :through => :ratings, :class_name => 'User', :source => 'user'

  has_permalink :name
end
