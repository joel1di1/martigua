class Match < ActiveRecord::Base
  belongs_to :championship
  belongs_to :location
  belongs_to :match_day
  belongs_to :visitor_team, class_name: 'Team'
  belongs_to :local_team, class_name: 'Team'
  has_one :selection

  has_many :availabilities
  has_many :users, through: :availabilities

  validates_presence_of :visitor_team, :local_team

  scope :finished, -> { where('starting_time < ?', Time.now) }
  scope :of, -> (team) { where('visitor_team_id = ? or local_team_id = ?', team.id, team.id) }

  scope :on, -> (match_day) { where(match_day: match_day) }

  after_create :create_empty_selection

  def name
    "#{local_team.name} - #{visitor_team.name}"
  end

  def to_s
    "#{local_team.name} - #{visitor_team.name} (#{format_schedule})"
  end

  def format_schedule
    if starting_time
      starting_time.to_formatted_s(:short) 
    else
      match_day.to_s
    end      
  end

  def future?
    (starting_time && starting_time.future?) || (starting_time.nil? && match_day.futur?)
  end

  def best_start_day
    starting_time ? starting_time.to_date : match_day.start_date
  end
  def best_end_day
    starting_time ? starting_time.to_date : match_day.end_date
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
    players = availabilities.includes(:user).where(availability: true).map(&:user)
    players.select!{|p| p.active? }
    User.sort_by_full_name players
  end

  def non_available_players
    players = availabilities.includes(:user).where(availability: false).map(&:user)
    players.select!{|p| p.active? }
    User.sort_by_full_name players
  end

  def uncertain_players
    players = User.active - availabilities.includes(:user).map(&:user)
    players.select!{|p| p.active? }
    User.sort_by_full_name players
  end

  def exempt?
    @exempt ||= false
  end

  def exempt=(exempt=false)
    @exempt = exempt
  end

  def title
    if exempt?
      "#{local_team.name} - exempt"
    else
      "#{local_team.name} - #{visitor_team.name}"
    end
  end

  def create_empty_selection
    selection ||= Selection.create!(match: self)
  end

  def selected_players
    User.sort_by_full_name selection.users
  end

  class << self
    def ask_for_availability(match_ids, force=false)
      matches = Match.where(id: [*match_ids].flatten).load
      User.where(active: true).each do |user|
        matches_to_ask = force ? matches : (matches - user.matches_reponds(matches))
        UserMailer.delay.ask_for_availability(matches_to_ask, user) unless matches_to_ask.empty?
      end
    end
    handle_asynchronously :ask_for_availability

    def exempt(team, match_day)
      match = Match.new local_team: team, match_day: match_day
      match.exempt = true
      match
    end
  end

end
