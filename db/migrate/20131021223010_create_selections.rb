class CreateSelections < ActiveRecord::Migration
  def change
    create_table :selections do |t|
      t.references :match, null: false, index: true

      t.timestamps
    end

    create_join_table :users, :selections
  end
end
