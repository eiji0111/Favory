FactoryBot.define do
  factory :community do
    name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
  end
end
