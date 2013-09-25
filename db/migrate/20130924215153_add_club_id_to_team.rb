class AddClubIdToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :club_id, :integer
    add_index :teams, :club_id
  end
end
