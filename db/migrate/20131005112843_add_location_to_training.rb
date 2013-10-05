class AddLocationToTraining < ActiveRecord::Migration
  def change
    remove_column :trainings, :location
    add_reference :trainings, :location, index: true
  end
end
