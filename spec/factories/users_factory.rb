FactoryGirl.define do
  
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    nickname { Faker::Name.last_name }
    email { Faker::Internet.email }

    trait :coach do
      is_coach true
    end
  end

end