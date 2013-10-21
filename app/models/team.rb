class Team < ActiveRecord::Base
  belongs_to :club
  validates_presence_of :name

  def last_match
    matches.finished.order('starting_time DESC').first
  end

  def matches
    Match.of(self)
  end

  def to_param
    "#{id} #{name}".parameterize
  end

  def match_on(match_day)
    match = matches.on(match_day).first
    match ||= Match.exempt(self, match_day)
  end
end
