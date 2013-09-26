json.array!(@matches) do |match|
  json.extract! match, :championship_id, :local_team_id, :visitor_team_id, :starting_time, :between_day1, :between_day2, :local_score, :visitor_score, :official_url
  json.url match_url(match, format: :json)
end
