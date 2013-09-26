class Match < ActiveRecord::Base
  belongs_to :championship
  belongs_to :visitor_team, class_name: 'Team'
  belongs_to :local_team, class_name: 'Team'

  validates_presence_of :visitor_team, :local_team

  scope :finished, -> { where('starting_time < ?', Time.now) }

  scope :of, -> (team) { where('visitor_team_id = ? or local_team_id = ?', team.id, team.id) }

end
