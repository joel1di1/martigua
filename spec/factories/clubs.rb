FactoryGirl.define do
  factory :club do
    name { Faker::Name.last_name }
  end
end
