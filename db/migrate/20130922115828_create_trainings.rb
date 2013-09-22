class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.datetime :date
      t.string :location

      t.timestamps
    end
  end
end
