json.array!(@trainings) do |training|
  json.extract! training, :date, :location
  json.url training_url(training, format: :json)
end
