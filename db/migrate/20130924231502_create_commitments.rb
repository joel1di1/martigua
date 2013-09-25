class CreateCommitments < ActiveRecord::Migration
  def change
    create_table :commitments do |t|
      t.references :team, index: true
      t.references :championship, index: true

      t.timestamps
    end
  end
end
