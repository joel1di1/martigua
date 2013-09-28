class Team < ActiveRecord::Base
  belongs_to :club
  has_many :matches
  validates_presence_of :name

  def last_match
    matches.finished.order('starting_time DESC').first
  end

  def next_match
    matches.to_come.sort{|a,b| (a.starting_time || a.between_day1) <=> (b.starting_time || b.between_day1)}.first
  end

  def matches
    Match.of(self)
  end

end
