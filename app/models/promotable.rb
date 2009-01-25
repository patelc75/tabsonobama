module Promotable
  def promoted?
    !promotion.nil?
  end
  alias :featured? :promoted?
  
  def promote!(promotion_locations={}, promoter=nil)
    return if promoted?
    
    # default to showing on both homee page and index
    promotion_locations = {:home_page => true, :index_page => true}.merge(promotion_locations)
    
    home_page = promotion_locations[:home_page]
    index_page = promotion_locations[:index_page]
    
    p = Promotion.create!(:item => self, 
                          :home_page => home_page, 
                          :index_page => index_page,
                          :user => promoter)
   self.promotion = p
  end
  
  def unpromote!
    return unless promoted?
    
    self.promotion.destroy
  end
  
  def promoted_by
    return unless promoted?
    
    promotion.user
  end
end