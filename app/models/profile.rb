class Profile < ActiveRecord::Base
  belongs_to :user

  validates_format_of :name, :with => Authentication.name_regex, :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of :name, :maximum => 100
end
