class CreateTrainingAvailabilities < ActiveRecord::Migration
  def change
    create_table :training_availabilities do |t|
      t.references :user, index: true, null: false
      t.references :training, index: true, null: false
      t.boolean :available

      t.timestamps
    end
  end
end
