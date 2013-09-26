class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.references :championship, null: false, index: true
      t.integer :local_team_id, null: false
      t.integer :visitor_team_id, null: false
      t.datetime :starting_time
      t.date :between_day1
      t.date :between_day2
      t.integer :local_score
      t.integer :visitor_score
      t.string :official_url

      t.timestamps
    end
  end
end
