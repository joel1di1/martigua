class CreateAvailabilities < ActiveRecord::Migration
  def change
    create_table :availabilities do |t|
      t.references :user, null: false, index: true
      t.references :match, null: false, index: true
      t.boolean :availability, null: false, default: false

      t.timestamps
    end

    add_index :availabilities, [:user_id, :match_id], unique: true
  end
end
