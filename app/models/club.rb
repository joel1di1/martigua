class Club < ActiveRecord::Base
  has_many :teams
  validates_presence_of :name

  def last_matches
    teams.map(&:last_match)
  end

  def next_trainings
    Training.nexts
  end

end
