module MatchesHelper
  def format_schedule(match)
    if match.starting_time
      match.starting_time.to_formatted_s(:short) 
    elsif match.between_day1 && match.between_day2
      "#{match.between_day1.to_formatted_s(:short)}/#{match.between_day2.to_formatted_s(:short)}"
    else
      "-"
    end      
  end
end
