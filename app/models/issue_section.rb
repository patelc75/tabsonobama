class IssueSection < ActiveRecord::Base
  has_many :ratings, :as => :issue
  has_many :raters, :through => :ratings, :class_name => 'User', :source => 'user'
  
  belongs_to :issue_group
  has_permalink :name
end
