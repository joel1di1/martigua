FactoryGirl.define do
  factory :team do
    club
    name { ["psc", "finance", "martigua", "p18"].sample }
  end
end
