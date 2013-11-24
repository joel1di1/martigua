class MatchDay < ActiveRecord::Base
  has_many :matches

  scope :next,     -> { where('end_date >= ?', Date.today).order('end_date ASC').first }
  scope :previous, -> { where('start_date <= ?', Date.today).order('start_date DESC').first }
  scope :next_in_7, -> { where('end_date >= ?', 2.days.from_now).order('end_date ASC').first }

  def futur?
    end_date > Date.today
  end

  def to_s
    "#{num}: #{start_date.to_s(:short)}/#{end_date.to_s(:short)}"
  end

  def selected_players
    User.joins(selections: :match).where(matches: { match_day_id: self.id } ).distinct
  end

end
