class AddRatingColumnWeeklyRadioAddressCabinetMember < ActiveRecord::Migration
  def self.up
    WeeklyRadioAddress.add_ratings_columns
    CabinetMember.add_ratings_columns
  end

  def self.down
    WeeklyRadioAddress.add_ratings_columns
    CabinetMember.remove_ratings_columns    
  end
end
