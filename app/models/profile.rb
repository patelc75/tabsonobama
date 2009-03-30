class Profile < ActiveRecord::Base
  has_one :affiliation
  belongs_to :user
  
  validates_format_of :first_name, :with => Authentication.name_regex, :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of :first_name, :maximum => 50
  
  validates_format_of :last_name, :with => Authentication.name_regex, :message => Authentication.bad_name_message, :allow_nil => true
  validates_length_of :last_name, :maximum => 50
  
  #validates_presence_of :zip, :if => :in_us?, :message => "Must have zip code"
  #validates_numericality_of :zip, :less_than => 100000
  
  validates_length_of :zip, :maximum => 5, :if => :in_usa?, :message => "Invalid zip code"
  validates_length_of :zip, :minimum => 5, :if => :in_usa?, :message => "Invalid zip code"
  	
  validates_presence_of :country_code
  
  def in_usa?
    self.country_code == 6  #6 = U S of A
  end
end