require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト', type: :system do
  let!(:customer) { create(:customer) }
  let!(:another_man_customer) { create(:customer) }
  let!(:another_woman_customer) { create(:customer, sex: 1) }
  let!(:community) { create(:community, owner_id: customer.id, valid_status: 1) }
  
  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end
  
  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ログアウトアイコンはSTEP1でテスト済み' do
      subject { current_path }

      it 'サイトロゴを押すと、自分のユーザ詳細画面に遷移する' do
        click_on 'logo'
        is_expected.to eq '/customers/' + customer.id.to_s
      end
      it '通知アイコンを押すと、通知一覧画面に遷移する' do
        click_link href: notifications_path
        is_expected.to eq '/notifications'
      end
    end
  end
  
  describe 'フッターのテスト: ログインしている場合' do
    context 'リンクの内容を確認' do
      subject { current_path }

      it '四角アイコンを押すと、男性会員一覧画面に遷移する' do
        click_link href: customer_men_path
        is_expected.to eq '/customers/men'
      end
      it '丸アイコンを押すと、女性会員一覧画面に遷移する' do
        click_link href: customer_women_path
        is_expected.to eq '/customers/women'
      end
      it 'コミュニティアイコンを押すと、コミュニティ一覧画面に遷移する' do
        click_link href: communities_path
        is_expected.to eq '/communities'
      end
      it 'ハートアイコンを押すと、お気に入り一覧画面に遷移する' do
        click_link href: followed_path
        is_expected.to eq '/customers/followed'
      end
      it '家アイコンを押すと、マイページ画面に遷移する' do
        all('footer a').last.click
        is_expected.to eq '/customers/' + customer.id.to_s
      end
    end
  end
  
  describe 'マイページのテスト' do
    context '表示内容の確認' do
      it '会員の名前が表示されている' do
        expect(page).to have_content customer.name
      end
      it '会員のメールアドレスが表示されている' do
        expect(page).to have_content customer.email
      end
      it '会員のニックネームが表示されている' do
        expect(page).to have_content customer.nickname
      end
      it '自衛官認証申請ボタンが表示されている' do
        expect(page).to have_link "自衛官認証申請"
      end
      it '編集アイコンが表示されている' do
        expect(page).to have_link nil, href: edit_customer_path(customer.id)
      end
    end
    
    context 'マイページ更新成功のテスト' do
      before do
        click_link nil, href: edit_customer_path(customer.id)
        @customer_old_profile_image = customer.profile_image
        @customer_old_one_thing = customer.one_thing
        @customer_old_name = customer.name
        @customer_old_email = customer.email
        @customer_old_nickname = customer.nickname
        @customer_old_birthday = customer.birthday
        @customer_old_address = customer.address
        @customer_old_birthplace = customer.birthplace
        @customer_old_work_location = customer.work_location
        @customer_old_jobs = customer.jobs
        @customer_annual_income = customer.annual_income
        @customer_old_height = customer.height
        @customer_old_body_shape = customer.body_shape
        @customer_old_blood_type = customer.blood_type
        @customer_old_personality = customer.personality
        @customer_old_holiday = customer.holiday
        @customer_old_car = customer.car
        @customer_old_hobby = customer.hobby
        @customer_old_cigarettes = customer.cigarettes
        @customer_old_alcohol = customer.alcohol
        @customer_old_housemate = customer.housemate
        @customer_old_marriage_history = customer.marriage_history
        @customer_old_children = customer.children
        @customer_old_willingness_to_marry = customer.willingness_to_marry
        @customer_old_want_kids = customer.want_kids
        @customer_old_hope_encounter = customer.hope_encounter
        @customer_old_date_cost = customer.date_cost
        @customer_old_introduction = customer.introduction
        attach_file 'customer[profile_image]', "#{Rails.root}/spec/fixtures/image/test.jpg"
        fill_in 'customer[one_thing]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[nickname]', with: Faker::Lorem.characters(number: 10)
        select '1990', from: 'customer_birthday_1i'
        select '12', from: 'customer_birthday_2i'
        select '31', from: 'customer_birthday_3i'
        select '東京都', from: 'customer_address'
        select '東京都', from: 'customer_birthplace'
        select '東京都', from: 'customer_work_location'
        fill_in 'customer[jobs]', with: Faker::Lorem.characters(number: 10)
        select '~250', from: 'customer_annual_income'
        select '165', from: 'customer_height'
        select '普通', from: 'customer_body_shape'
        select 'AB', from: 'customer_blood_type'
        select '明るい', from: 'customer_personality'
        select '土日', from: 'customer_holiday'
        select 'あり', from: 'customer_car'
        fill_in 'customer[hobby]', with: Faker::Lorem.characters(number: 10)
        select '吸わない', from: 'customer_cigarettes'
        select '飲まない', from: 'customer_alcohol'
        select '一人暮らし', from: 'customer_housemate'
        select 'なし', from: 'customer_marriage_history'
        select 'いない', from: 'customer_children'
        select 'わからない', from: 'customer_willingness_to_marry'
        select 'いまはまだ', from: 'customer_want_kids'
        select 'チャットでよく話してから', from: 'customer_hope_encounter'
        select '男性が全て払う', from: 'customer_date_cost'
        fill_in 'customer[introduction]', with: Faker::Lorem.characters(number: 10)
        click_button '変更する'
      end
      
      it 'プロフィール画像が正しく更新される' do
        expect(customer.reload.profile_image).not_to eq @customer_old_profile_image
      end
      it 'ひとことが正しく更新される' do
        expect(customer.reload.one_thing).not_to eq @customer_old_one_thing
      end
      it '名前が正しく更新される' do
        expect(customer.reload.name).not_to eq @customer_old_name
      end
      it 'メールアドレスが正しく更新される' do
        expect(customer.reload.email).not_to eq @customer_old_email
      end
      it 'ニックネームが正しく更新される' do
        expect(customer.reload.nickname).not_to eq @customer_old_nickname
      end
      it '生年月日が正しく更新される' do
        expect(customer.reload.birthday).not_to eq @customer_old_birthday
      end
      it '居住地が正しく更新される' do
        expect(customer.reload.address).not_to eq @customer_old_address
      end
      it '出身地が正しく更新される' do
        expect(customer.reload.birthplace).not_to eq @customer_old_nickname
      end
      it '勤務地が正しく更新される' do
        expect(customer.reload.work_location).not_to eq @customer_old_work_location
      end
      it '仕事が正しく更新される' do
        expect(customer.reload.jobs).not_to eq @customer_old_jobs
      end
      it '年収が正しく更新される' do
        expect(customer.reload.annual_income).not_to eq @customer_old_annual_income
      end
      it '身長が正しく更新される' do
        expect(customer.reload.height).not_to eq @customer_old_height
      end
      it '体型が正しく更新される' do
        expect(customer.reload.body_shape).not_to eq @customer_old_body_shape
      end
      it '血液型が正しく更新される' do
        expect(customer.reload.blood_type).not_to eq @customer_old_blood_type
      end
      it '性格が正しく更新される' do
        expect(customer.reload.personality).not_to eq @customer_old_personality
      end
      it '休日が正しく更新される' do
        expect(customer.reload.holiday).not_to eq @customer_old_holiday
      end
      it '私有者が正しく更新される' do
        expect(customer.reload.car).not_to eq @customer_old_car
      end
      it '趣味が正しく更新される' do
        expect(customer.reload.hobby).not_to eq @customer_old_hobby
      end
      it '煙草が正しく更新される' do
        expect(customer.reload.cigarettes).not_to eq @customer_old_cigarettes
      end
      it 'お酒が正しく更新される' do
        expect(customer.reload.nickname).not_to eq @customer_old_nickname
      end
      it '同居人が正しく更新される' do
        expect(customer.reload.alcohol).not_to eq @customer_old_alcohol
      end
      it '結婚歴が正しく更新される' do
        expect(customer.reload.marriage_history).not_to eq @customer_old_marriage_history
      end
      it '子供の有無が正しく更新される' do
        expect(customer.reload.children).not_to eq @customer_old_children
      end
      it '結婚に対する意思が正しく更新される' do
        expect(customer.reload.willingness_to_marry).not_to eq @customer_old_willingness_to_marry
      end
      it '子供が欲しいかが正しく更新される' do
        expect(customer.reload.want_kids).not_to eq @customer_old_want_kids
      end
      it '出会うまでの希望が正しく更新される' do
        expect(customer.reload.hope_encounter).not_to eq @customer_old_hope_encounter
      end
      it '初回デート費用が正しく更新される' do
        expect(customer.reload.date_cost).not_to eq @customer_old_date_cost
      end
      it '自己紹介が正しく更新される' do
        expect(customer.reload.introduction).not_to eq @customer_old_introduction
      end
      it 'リダイレクト先が、自分のマイページ画面になっている' do
        expect(current_path).to eq '/customers/' + customer.id.to_s
      end
    end
    
    context 'マイページ更新失敗のテスト' do
      before do
        click_link nil, href: edit_customer_path(customer.id)
        fill_in 'customer[name]', with: ''
        fill_in 'customer[email]', with: ''
        fill_in 'customer[nickname]', with: ''
        click_button '変更する'
      end
      
      it '更新に失敗し、エラーメッセージを表示させる' do
        expect(current_path).to eq '/customers/' + customer.id.to_s + '/edit'
        expect(page).to have_content 'プロフィールを更新できませんでした'
      end
    end
    
    context '自衛官認証申請表示画面の確認' do
      before do
        click_link "自衛官認証申請"
      end
      
      it 'URLが正しい' do
        expect(current_path).to eq '/army_requests/new'
      end
      it '「陸・海・空」選択フォームが表示される' do
        expect(page).to have_field 'army_request[army_type]'
      end
      it '駐屯地・基地フォームが表示される' do
        expect(page).to have_field 'army_request[base]'
      end
      it '階級選択フォームが表示される' do
        expect(page).to have_field 'army_request[army_class]'
      end
      it '職種フォームが表示される' do
        expect(page).to have_field 'army_request[occupation]'
      end
      it '認識番号フォームが表示される' do
        expect(page).to have_field 'army_request[identification_number]'
      end
      it '自衛官認証写真選択フォームが表示される' do
        expect(page).to have_field 'army_request[identification_image]'
      end
      it '申請するボタンが表示される' do
        expect(page).to have_button '申請する'
      end
    end
    
    context '自衛官認証申請に成功する' do
      before do
        click_link "自衛官認証申請"
        select '陸自', from: 'army_request_army_type'
        fill_in 'army_request[base]', with: 'テスト駐屯地'
        select '士長', from: 'army_request_army_class'
        fill_in 'army_request[occupation]', with: '航空科'
        fill_in 'army_request[identification_number]', with: 'g1076873'
        attach_file 'army_request[identification_image]', "#{Rails.root}/spec/fixtures/image/test.jpg"
      end
      
      it 'マイページ画面に遷移し、申請完了のメッセージが表示される' do
        click_on '申請する'
        expect(current_path).to eq '/customers/' + customer.id.to_s
        expect(page).to have_content '申請が完了しました。'
      end
    end
    
    context '自衛官認証申請に失敗する' do
      before do
        click_link "自衛官認証申請"
        fill_in 'army_request[base]', with: ''
        fill_in 'army_request[occupation]', with: ''
        fill_in 'army_request[identification_number]', with: ''
      end
      
      it '申請フォームでエラーメッセージが表示される' do
        click_on '申請する'
        expect(current_path).to eq '/army_requests/new'
        expect(page).to have_content '申請できませんでした。入力内容をご確認ください。'
      end
    end
  end
  
  describe '会員一覧のテスト' do
    before do
      visit customer_men_path
    end
    
    context '男性会員一覧画面表示内容の確認' do
      it '絞り込みボタンが表示されている' do
        expect(page).to have_button '絞り込み'
      end
      it '他の男性会員の年齢が表示されている' do
        expect(page).to have_content customer.age
      end
    end
    
    context '他の男性会員詳細画面表示内容の確認' do
      before do
        click_link href: customer_path(another_man_customer.id)
      end
      
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/' + another_man_customer.id.to_s
      end
      it '他の男性会員名が表示されている' do
        expect(page).to have_content another_man_customer.nickname
      end
    end
    
    
    context 'お気に入りに成功する', js: true do
      before do
        click_link href: customer_path(another_man_customer.id)
        click_button 'button'
      end
      
      it 'ふぁぼされた人のカウントが１増える' do
        expect(page).to have_content 'ふぁぼされた 1人'
      end
      it 'お気に入り一覧の画面に追加されている' do
        visit followed_path
        expect(page).to have_link href: customer_path(another_man_customer.id)
      end
    end
  end
  
  describe 'コミュニティのテスト' do
    before do
      visit communities_path
    end
    
    context 'コミュニティ一覧画面表示内容の確認' do
      it 'コミュニティ名が表示されている' do
        expect(page).to have_content community.name
      end
      it 'コミュニティ新規作成ボタンが表示されている' do
        expect(page).to have_button '新しくコミュニティを作る'
      end
    end
    
    context 'コミュニティの新規作成に成功する', js: true do
      before do
        click_button "新しくコミュニティを作る"
        attach_file 'community[community_image]', "#{Rails.root}/spec/fixtures/image/test.jpg"
        fill_in 'community[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'community[introduction]', with: Faker::Lorem.characters(number: 20)
        click_button '作成'
      end
      
      it '作成完了のメッセージが表示される' do
        expect(page).to have_content '管理者が内容を確認・承認したのち、こちらに反映されます'
      end
    end
    
    context 'コミュニティ詳細画面表示内容の確認' do
      before do
        click_link href: community_path(community.id)
      end
      
      it 'URLが正しい' do
        expect(current_path).to eq '/communities/' + community.id.to_s
      end
      it 'コミュニティ名が表示されている' do
        expect(page).to have_content community.name
      end
      it 'コミュニティの概要が表示されている' do
        expect(page).to have_content community.introduction
      end
    end
    
    context 'コミュニティ詳細画面でコメントに成功する', js: true do
      before do
        click_link href: community_path(community.id)
        find('#community_post_btn').click
        fill_in 'community_post[content]', with: 'テスト投稿'
      end
      
      it '投稿内容が正しく表示される' do
        click_button '投稿'
        expect(page).to have_content 'テスト投稿'
      end
    end
    
    context 'コメントに失敗する', js: true do
      before do
        click_link href: community_path(community.id)
        find('#community_post_btn').click
        fill_in 'community_post[content]', with: ''
      end
      
      it 'エラーメッセージが表示される' do
        click_button '投稿'
        expect(page).to have_content '内容を入力してください'
      end
    end
  end
end