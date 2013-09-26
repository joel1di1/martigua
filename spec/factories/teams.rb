FactoryGirl.define do
  factory :team do
    club
    name { Faker::Name.name }
  end
end
