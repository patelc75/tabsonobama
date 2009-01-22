class CabinetMember < ActiveRecord::Base
  acts_as_rated
  has_permalink :nominee
end
