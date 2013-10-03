class AddIsCoachToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_coach, :boolean, null: false, default: false
  end
end
