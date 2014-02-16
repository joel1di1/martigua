class CreateTrainingPresences < ActiveRecord::Migration
  def change
    create_table :training_presences do |t|
      t.references :training, index: true
      t.references :user, index: true
      t.integer :status

      t.timestamps
    end
  end
end
