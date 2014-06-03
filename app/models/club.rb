class Club < ActiveRecord::Base
  has_many :teams
  validates_presence_of :name

  def last_matches
    match_day = MatchDay.previous
    teams.map{ |t| t.match_on(match_day) }
  end

  def next_trainings
    Training.nexts
  end

  def previous_trainings
    Training.previous
  end

  def next_matches
    match_day = MatchDay.next
    if match_day
      teams.map{ |t| t.match_on(match_day) }
    else
      teams.map { |t| nil }
    end
  end

end
