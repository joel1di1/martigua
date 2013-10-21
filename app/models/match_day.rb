class MatchDay < ActiveRecord::Base
  has_many :matches

  def to_s
    "#{num}: #{start_date.to_s(:short)}/#{end_date.to_s(:short)}"
  end
end
