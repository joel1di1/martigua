class CreateMatchDays < ActiveRecord::Migration
  def change
    create_table :match_days do |t|
      t.integer :num, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false

      t.timestamps
    end

    add_index :match_days, :start_date, order: :asc
  end
end
