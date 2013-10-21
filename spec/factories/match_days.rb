# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match_day do
    start_date { 3.days.from_now }
    end_date { 10.days.from_now }
  end
end
