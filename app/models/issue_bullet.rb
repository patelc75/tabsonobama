class IssueBullet < ActiveRecord::Base
  acts_as_rateable
    
  belongs_to :issue_section
  has_permalink :name
end
