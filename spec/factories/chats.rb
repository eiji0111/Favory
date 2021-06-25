FactoryBot.define do
  factory :chat do
    customer
    room
    message { Faker::Lorem.characters(number: 10) }
  end
end