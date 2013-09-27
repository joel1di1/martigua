class AddLocationToMatch < ActiveRecord::Migration
  def change
    add_reference :matches, :location, index: true
  end
end
