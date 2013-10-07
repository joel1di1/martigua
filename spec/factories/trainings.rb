FactoryGirl.define do
  factory :training do
    date { [-8, -5, -1, 1, 4, 9].sample.days.from_now}
  end
end
