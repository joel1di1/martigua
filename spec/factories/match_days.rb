# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match_day do
    num { [1,2,3,4,5].sample }
    start_date { 3.days.from_now }
    end_date { 10.days.from_now }

    trait(:finished) do
      start_date { 10.days.ago }
      end_date { 9.days.ago }
    end

    trait(:futur) do
      start_date { 9.days.from_now }
      end_date { 10.days.from_now }
    end
  end
end
