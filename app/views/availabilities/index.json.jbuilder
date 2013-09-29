json.array!(@availabilities) do |availability|
  json.extract! availability, :user_id, :match_id
  json.url availability_url(availability, format: :json)
end
