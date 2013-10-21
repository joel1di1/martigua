class RemoveBetweenDaysToMatches < ActiveRecord::Migration
  def change
    change_table :matches do |t|
      t.remove :between_day1, :between_day2
    end
  end
end
