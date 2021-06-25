FactoryBot.define do
  factory :army_request do
    customer
    army_type { '陸自' }
    base { Faker::Lorem.characters(number: 10) }
    army_class { '士長' }
    occupation { Faker::Lorem.characters(number: 10) }
    identification_number { Faker::Lorem.characters(number: 10) }
    identification_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/image/test.jpg'), 'image/jpg') }
  end
end