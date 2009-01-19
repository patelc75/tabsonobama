class Profile < ActiveRecord::Base
  has_one :affiliation
  belongs_to :user
  
  validates_format_of :first_name, :with => Authentication.name_regex, :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of :first_name, :maximum => 50
  
  validates_format_of :last_name, :with => Authentication.name_regex, :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of :last_name, :maximum => 50
end