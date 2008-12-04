class IssueBullet < ActiveRecord::Base
  has_many :ratings, :as => :issue
  has_many :raters, :through => :ratings, :class_name => 'User', :source => 'user'
  
  belongs_to :issue_section
  has_permalink :name
end
