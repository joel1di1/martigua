class CreateScoreEvents < ActiveRecord::Migration
  def change
    create_table :score_events do |t|
      t.references :user, index: true
      t.string :label
      t.integer :value
      t.references :training_presence, index: true

      t.timestamps
    end
  end
end
