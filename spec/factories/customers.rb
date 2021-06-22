FactoryBot.define do
  factory :customer do
    email { 'test1@example.com' }
    password { 'password' }
    name { 'テストユーザー' }
    nickname { 'テストニックネーム' }
    birthday { Date.new(1995, 1, 11) }
  end
end