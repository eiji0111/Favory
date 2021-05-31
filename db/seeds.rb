Admin.create!(
  email: "a@a",
  password: "aaaaaa"
  )
  
  from = Time.parse("1950/01/01")
  to = Time.parse("2000/01/01")
  date = Random.rand(from..to)
  
Customer.create!(
  name: "石原さとみ",
  nickname: "さとみん",
  email: "b@b",
  birthday: date,
  sex: 1,
  password: "bbbbbb",
  address: 13,
  is_valid: true,
  one_thing: "よろしくお願いします",
  hobby: "映画鑑賞",
  jobs: "女優",
  annual_income: 7,
  marriage_history: "なし",
  children: false,
  personality: 1
  )