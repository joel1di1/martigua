class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.references :team, null: false, index: true
      t.references :championship, null: false, index: true

      t.timestamps
    end
  end
end
