FactoryGirl.define do
  factory :match do
    championship
    association :local_team, factory: :team
    association :visitor_team, factory: :team
    starting_time { 10.days.ago }
    between_day1 { 11.days.ago }
    between_day2 { 9.days.ago }
    local_score { Faker::Number.number(2) }
    visitor_score { Faker::Number.number(2) }
    official_url { Faker::Internet.url }

    trait(:finished) do
      starting_time { 10.days.ago }
      between_day1 { 11.days.ago }
      between_day2 { 9.days.ago }
    end

    trait(:futur) do
      starting_time { 10.days.from_now }
      between_day1 { 9.days.from_now }
      between_day2 { 11.days.from_now }
    end
  end
end
