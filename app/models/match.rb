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

  def name
    "#{local_team.name} - #{visitor_team.name}"
  end

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

  def best_start_day
    starting_time ? starting_time.to_date : between_day1
  end
  def best_end_day
    starting_time ? starting_time.to_date : between_day2
  end

  def self.schedule_for(matches)
    start_day = matches.map(&:best_start_day).sort.first
    end_day = matches.map(&:best_end_day).sort.last
    if start_day == end_day
      start_day.to_formatted_s(:short)
    else
      "#{start_day.to_formatted_s(:short)} / #{end_day.to_formatted_s(:short)}"
    end
  end

  def available_players
    availabilities.includes(:user).where(availability: true).map(&:user)
  end

  def non_available_players
    availabilities.includes(:user).where(availability: false).map(&:user)
  end

  def uncertain_players
    User.active - availabilities.includes(:user).map(&:user)
  end

  class << self
    def ask_for_availability(match_ids)
      matches = Match.where(id: [*match_ids].flatten).all
      User.where(active: true).each do |user| 
        UserMailer.delay.ask_for_availability(matches, user)
      end
    end
    handle_asynchronously :ask_for_availability
  end

end
