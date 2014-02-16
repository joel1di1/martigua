json.array!(@training_presences) do |training_presence|
  json.extract! training_presence, :training_id, :user_id, :status
  json.url training_presence_url(training_presence, format: :json)
end
