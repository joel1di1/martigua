FactoryGirl.define do
  factory :match do
    championship
    association :local_team, factory: :team
    association :visitor_team, factory: :team
    starting_time { 10.days.ago }
    association :match_day
    local_score { Faker::Number.number(2) }
    visitor_score { Faker::Number.number(2) }
    official_url { Faker::Internet.url }

    trait(:finished) do
      starting_time { 10.days.ago }
      association :match_day, :finished
    end

    trait(:futur) do
      starting_time { 10.days.from_now }
      association :match_day, :futur
    end
  end
end
