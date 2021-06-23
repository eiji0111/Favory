FactoryBot.define do
  factory :customer do
    email { Faker::Internet.email }
    password { 'password' }
    name { Faker::Lorem.characters(number: 10) }
    nickname { Faker::Lorem.characters(number: 10) }
    birthday { Date.new(1995, 1, 11) }
    current_sign_in_at { Time.now }
  end
end