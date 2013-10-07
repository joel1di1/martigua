# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :training_availaility do
    association :user
    association  :training
    available { [true, false].sample }
  end
end
