class AddMatchDayToMatch < ActiveRecord::Migration
  def change
    add_reference :matches, :match_day, index: true
  end
end
