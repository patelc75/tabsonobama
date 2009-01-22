class CabinetMember < ActiveRecord::Base
  acts_as_rated
  
  has_permalink :nominee
  def to_param
    self.permalink
  end
end