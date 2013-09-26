class Team < ActiveRecord::Base
  belongs_to :club
  validates_presence_of :name

  def last_match
    matches.finished.order('starting_time DESC').first
  end

  def matches
    Match.of(self)
  end

end
