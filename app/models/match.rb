class Match < ActiveRecord::Base
  belongs_to :championship
  belongs_to :location
  belongs_to :visitor_team, class_name: 'Team'
  belongs_to :local_team, class_name: 'Team'

  has_many :availabilities
  has_many :users, through: :availabilities

  validates_presence_of :visitor_team, :local_team

  scope :finished, -> { where('starting_time < ?', Time.now) }
  scope :to_come, -> { where('(starting_time > ?) OR (starting_time IS NULL AND between_day1 > ?)', Time.now, Time.now) }
  scope :of, -> (team) { where('visitor_team_id = ? or local_team_id = ?', team.id, team.id) }

  def to_s
    "#{local_team.name} - #{visitor_team.name} (#{format_schedule})"
  end

  def format_schedule
    if starting_time
      starting_time.to_formatted_s(:short) 
    elsif between_day1 && between_day2
      "#{between_day1.to_formatted_s(:short)},#{between_day2.to_formatted_s(:short)}"
    else
      "-"
    end      
  end

  def future?
    (starting_time && starting_time.future?) || (starting_time.nil? && between_day1.future?)
  end

end
