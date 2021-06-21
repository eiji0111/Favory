Admin.create!(
  email: "a@a.com",
  password: "aaaaaa"
  )
  
50.times do |n|
  Customer.create!(
    name: Faker::Name.name,
    nickname: Faker::Name.name,
    email: "test#{n + 1}@test.com",
    birthday: Date.new(1998, 12, 24),
    sex: 0,
    password: "aaaaaa",
    address: 13,
    one_thing: "よろしくお願いします",
    introduction: "テストユーザー",
    hobby: "映画鑑賞",
    jobs: "テスト",
    annual_income: 7,
    current_sign_in_at: Time.zone.now,
  )
end

50.times do |n|
  Customer.create!(
    name: Faker::Name.name,
    nickname: Faker::Name.name,
    email: "test#{n + 1}@gmail.com",
    birthday: Date.new(1998, 12, 24),
    sex: 1,
    password: "aaaaaa",
    address: 13,
    one_thing: "よろしくお願いします",
    introduction: "テストユーザー",
    hobby: "映画鑑賞",
    jobs: "テスト",
    annual_income: 7,
    current_sign_in_at: Time.zone.now,
  )
end

50.times do |n|
  Community.create!(
    name: "test#{n + 1}",
    introduction: "テストコミュニティ",
    owner_id: 1,
    valid_status: 1,
  )
end
