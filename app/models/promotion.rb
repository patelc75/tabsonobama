class Promotion < ActiveRecord::Base
  belongs_to :item, :polymorphic => true
  belongs_to :user, :foreign_key => :promoter_id
  
  named_scope :home_page, :conditions => {:home_page => true}, :order => "created_at DESC"
  named_scope :index_page, :conditions => {:index_page => true}, :order => "created_at DESC"
  
  named_scope :cabinet_member, :conditions => {:item_type => "CabinetMember"}, :limit => 1
  named_scope :issue_bullet, :conditions => {:item_type => "IssueBullet"}, :limit => 1
  named_scope :weekly_radio_address, :conditions => {:item_type => "WeeklyRadioAddress"}, :limit => 1
end
