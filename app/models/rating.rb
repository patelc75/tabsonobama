class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :issue, :polymorphic => true
end
