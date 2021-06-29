require 'faker'

# Admin.create!(
#   email: "a@a.com",
#   password: "aaaaaa"
#   )
  
50.times do |n|
  Customer.create!(
    email: Faker::Internet.email,
    password: "123456",
    name: "テスト#{n + 1}",
    nickname: Gimei.unique.male.kanji,
    sex: 0,
    army_flag: [true, false].sample,
    one_thing: "よろしくお願いします",
    introduction: "テストユーザー",
    birthday: Faker::Date.between(from: '1986-01-01', to: '2001-01-01'),
    address: rand(1..47),
    birthplace: rand(1..47),
    work_location: rand(1..47),
    jobs: "テストjob",
    annual_income: rand(1..9),
    height: rand(155..185),
    body_shape: rand(1..8),
    blood_type: rand(1..4),
    personality: rand(1..6),
    holiday: rand(1..4),
    car: rand(1..2),
    hobby: "テストhobby",
    cigarettes: rand(1..3),
    alcohol: rand(1..4),
    housemate: rand(1..6),
    marriage_history: rand(1..2),
    children: rand(1..2),
    willingness_to_marry: rand(1..4),
    want_kids: rand(1..4),
    hope_encounter: rand(1..3),
    date_cost: rand(1.5),
    current_sign_in_at: Time.zone.now,
  )
end

50.times do |n|
  Customer.create!(
    email: Faker::Internet.email,
    password: "123456",
    name: "テスト#{n + 1}",
    nickname: Gimei.unique.female.kanji,
    sex: 1,
    army_flag: [true, false].sample,
    one_thing: "よろしくお願いします",
    introduction: "テストユーザー",
    birthday: Faker::Date.between(from: '1986-01-01', to: '2001-01-01'),
    address: rand(1..47),
    birthplace: rand(1..47),
    work_location: rand(1..47),
    jobs: "テストjob",
    annual_income: rand(1..9),
    height: rand(155..185),
    body_shape: rand(1..8),
    blood_type: rand(1..4),
    personality: rand(1..6),
    holiday: rand(1..4),
    car: rand(1..2),
    hobby: "テストhobby",
    cigarettes: rand(1..3),
    alcohol: rand(1..4),
    housemate: rand(1..6),
    marriage_history: rand(1..2),
    children: rand(1..2),
    willingness_to_marry: rand(1..4),
    want_kids: rand(1..4),
    hope_encounter: rand(1..3),
    date_cost: rand(1.5),
    current_sign_in_at: Time.zone.now,
  )
end

# 20.times do |n|
#   Community.create!(
#     name: "test#{n + 1}",
#     introduction: "テストコミュニティ。テストコミュニティ。",
#     owner_id: 1,
#     valid_status: 1,
#   )
# end
