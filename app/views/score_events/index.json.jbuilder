json.array!(@score_events) do |score_event|
  json.extract! score_event, :user_id, :label, :value, :training_presence_id
  json.url score_event_url(score_event, format: :json)
end
