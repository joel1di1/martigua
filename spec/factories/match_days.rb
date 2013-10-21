# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :match_day do
    num { [1,2,3,4,5].sample }
    start_date { 3.days.from_now }
    end_date { 10.days.from_now }
  end
end
