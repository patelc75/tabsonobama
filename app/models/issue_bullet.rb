class IssueBullet < ActiveRecord::Base
  acts_as_rated
    
  belongs_to :issue_section
  has_permalink :name
end
