require 'rails_helper'

describe '管理者側テスト', type: :system do
  
  let!(:admin) { create(:admin) }
  let!(:customer) { create(:customer) }
  
  describe '管理者ログインのテスト' do
    before do
      visit new_admin_session_path
    end
    
    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/admin/sign_in'
      end
      it 'メールアドレスフォームが表示される' do
        expect(page).to have_field 'admin[email]'
      end
      it 'パスワードフォームが表示される' do
        expect(page).to have_field 'admin[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end
    
    context 'ログイン成功のテスト' do
      before do
        fill_in 'admin[email]', with: admin.email
        fill_in 'admin[password]', with: admin.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、管理者トップ画面になっている' do
        expect(current_path).to eq '/admin/top'
      end
    end
    
    context 'ログイン失敗のテスト' do
      before do
        fill_in 'admin[email]', with: ''
        fill_in 'admin[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログイン画面にリダイレクトされ、エラーメッセージを表示する' do
        expect(current_path).to eq '/admin/sign_in'
        expect(page).to have_content 'メールアドレス もしくはパスワードが不正です。'
      end
    end
  end
  
  describe '管理者トップ画面のテスト' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
    end
    
    context '表示内容の確認' do
      it '男性会員一覧リンクが表示されている' do
        expect(page).to have_link '男性会員'
      end
      it '女性会員一覧リンクが表示されている' do
        expect(page).to have_link '女性会員'
      end
      it 'コミュニティ一覧リンクが表示されている' do
        expect(page).to have_link 'コミュニティ'
      end
      it '自衛官申請一覧リンクが表示されている' do
        expect(page).to have_link '自衛官申請'
      end
    end
    
    context 'リンク内容の確認' do
      it '男性会員一覧リンクを押下すると男性会員一覧ページに遷移する' do
        click_link '男性会員'
        expect(current_path).to eq '/admin/customers/men'
      end
      it '女性会員一覧を押下すると女性会員一覧ページに遷移する' do
        click_link '女性会員'
        expect(current_path).to eq '/admin/customers/women'
      end
      it 'コミュニティ一覧を押下するとコミュニティ一覧ページに遷移する' do
        click_link 'コミュニティ'
        expect(current_path).to eq '/admin/communities'
      end
      it '自衛官申請一覧を押下すると自衛官申請一覧ページに遷移する' do
        click_link '自衛官申請'
        expect(current_path).to eq '/admin/army_requests'
      end
    end
  end
  
  describe '男性会員一覧のテスト' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit men_admin_customers_path
    end

    context '表示内容の確認' do
      it '男性会員のIDが表示されている' do
        expect(page).to have_content customer.id
      end
      it '男性会員の名前が表示されている' do
        expect(page).to have_content customer.name
      end
      it '男性会員の年齢が表示されている' do
        expect(page).to have_content customer.age
      end
      it '男性会員の居住地が表示されている' do
        expect(page).to have_content customer.address
      end
      it '男性会員の自衛官承認が表示されている' do
        expect(page).to have_content '非承認'
      end
      it '男性会員の会員ステータスが表示されている' do
        expect(page).to have_content '有効'
      end
    end
  end
  
  describe '女性会員一覧のテスト' do
    let!(:woman) { create(:customer, sex: 1) }

    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit women_admin_customers_path
    end

    context '表示内容の確認' do
      it '女性会員のIDが表示されている' do
        expect(page).to have_content woman.id
      end
      it '女性会員の名前が表示されている' do
        expect(page).to have_content woman.name
      end
      it '女性会員の年齢が表示されている' do
        expect(page).to have_content woman.age
      end
      it '女性会員の居住地が表示されている' do
        expect(page).to have_content woman.address
      end
      it '女性会員の自衛官承認が表示されている' do
        expect(page).to have_content '非承認'
      end
      it '女性会員の会員ステータスが表示されている' do
        expect(page).to have_content '有効'
      end
    end
  end
    
  describe '会員詳細画面のテスト' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit admin_customer_path(customer.id)
    end

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
      it '編集アイコンが表示されている' do
        expect(page).to have_link nil, href: edit_admin_customer_path(customer.id)
      end
      it '会員ステータスが表示されている' do
        expect(page).to have_content '会員ステータス 有効'
      end
      it '自衛官認証状況が表示されている' do
        expect(page).to have_content '自衛官認証未承認'
      end
    end
    
    context '会員情報更新成功のテスト' do
      before do
        click_link nil, href: edit_admin_customer_path(customer.id)
        @customer_old_profile_image = customer.profile_image
        @customer_old_is_valid = customer.is_valid
        @customer_old_sex = customer.sex
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
        choose 'customer_is_valid_false'
        choose 'customer_sex_woman'
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
      it '会員ステータスが正しく更新される' do
        expect(customer.reload.is_valid).not_to eq @customer_old_is_valid
      end
      it '性別が正しく更新される' do
        expect(customer.reload.sex).not_to eq @customer_old_sex
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
      it 'リダイレクト先が、会員詳細画面になっている' do
        expect(current_path).to eq '/admin/customers/' + customer.id.to_s
      end
    end
    
    context '会員情報更新失敗のテスト' do
      before do
        click_link nil, href: edit_admin_customer_path(customer.id)
        fill_in 'customer[name]', with: ''
        fill_in 'customer[email]', with: ''
        fill_in 'customer[nickname]', with: ''
        click_button '変更する'
      end
      
      it '更新に失敗し、エラーメッセージを表示させる' do
        expect(current_path).to eq '/admin/customers/' + customer.id.to_s + '/edit'
        expect(page).to have_content '会員情報を更新できませんでした'
      end
    end
    
    context '会員削除のテスト' do
      before do
        click_link nil, href: edit_admin_customer_path(customer.id)
      end
      
      it '削除するボタンを押下すると確認メッセージが表示される', js: true do
        click_link '削除する'
        expect(page.driver.browser.switch_to.alert.text).to eq "本当に削除しますか？"
        page.driver.browser.switch_to.alert.dismiss
      end
      
      it '削除する', js: true do
        click_link '削除する'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '会員を削除しました'
      end
    end
  end
  
  describe 'コミュニティ一覧のテスト' do
    let!(:community) { create(:community, owner_id: customer.id) }
    
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit admin_communities_path
    end
    
    context '表示内容の確認' do
      it 'コミュニティIDが表示されている' do
        expect(page).to have_content community.id
      end
      it 'コミュニティ名が表示されている' do
        expect(page).to have_content community.name
      end
      it 'コミュニティ概要が表示されている' do
        expect(page).to have_content community.introduction
      end
      it 'コミュニティステータスが表示されている' do
        expect(page).to have_content '申請待ち'
      end
    end
  end
  
  describe 'コミュニティ詳細画面のテスト' do
    let!(:community) { create(:community, owner_id: customer.id) }
    
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit admin_community_path(community.id)
    end
    
    context '表示内容の確認' do
      it 'コミュニティ名が表示されている' do
        expect(page).to have_content community.name
      end
      it 'コミュニティ概要が表示されている' do
        expect(page).to have_content community.introduction
      end
      it 'コミュニティ作成者が表示されている' do
        expect(page).to have_content customer.nickname
      end
      it 'コミュニティステータスが表示されている' do
        expect(page).to have_content '申請待ち'
      end
    end
    
    context 'コミュニティ情報更新成功のテスト' do
      before do
        click_link '編集する'
        @community_old_name = community.name
        @community_old_introduction = community.introduction
        @community_old_valid_status = community.valid_status
        fill_in 'community[name]', with: Faker::Lorem.characters(number: 10)
        fill_in 'community[introduction]', with: Faker::Lorem.characters(number: 10)
        choose 'community_valid_status_許可'
        click_button '変更する'
      end
      
      it 'コミュニティ名が正しく更新される' do
        expect(community.reload.name).not_to eq @community_old_name
      end
      it 'コミュニティ概要が正しく更新される' do
        expect(community.reload.introduction).not_to eq @community_old_introduction
      end
      it 'コミュニティステータスが正しく更新される' do
        expect(community.reload.valid_status).not_to eq @community_old_valid_status
      end
    end
    
    context 'コミュニティ情報更新失敗のテスト' do
      before do
        click_link '編集する'
        fill_in 'community[name]', with: ''
        fill_in 'community[introduction]', with: ''
        click_button '変更する'
      end
      
      it '更新に失敗し、エラーメッセージを表示させる' do
        expect(current_path).to eq '/admin/communities/' + community.id.to_s
        expect(page).to have_content 'コミュニティ名を入力してください'
        expect(page).to have_content 'コミュニティ名は2文字以上で入力してください'
        expect(page).to have_content 'コミュニティの概要を入力してください'
        expect(page).to have_content 'コミュニティの概要は10文字以上で入力してください'
      end
    end
  end
  
  describe '自衛官申請一覧のテスト' do
    let!(:army_request) { create(:army_request) }
    
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit admin_army_requests_path
    end
    
    context '表示内容の確認' do
      it '申請IDが表示されている' do
        expect(page).to have_content army_request.id
      end
      it '申請会員のIDが表示されている' do
        expect(page).to have_content army_request.customer.id
      end
      it '申請会員名が表示されている' do
        expect(page).to have_content army_request.customer.name
      end
      it '申請日が表示されている' do
        expect(page).to have_content army_request.created_at.strftime("%Y年%-m月%-d日 %H:%M")
      end
      it '申請ステータスが表示されている' do
        expect(page).to have_content '未承認'
      end
    end
  end
  
  describe '自衛官申請詳細画面のテスト' do
    let!(:army_request) { create(:army_request) }
    
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      visit admin_army_request_path(army_request.id)
    end
    
    context '表示内容の確認' do
      it '申請名が表示されている' do
        expect(page).to have_content army_request.customer.name
      end
      it '陸・海・空が表示されている' do
        expect(page).to have_content army_request.army_type
      end
      it '駐屯地・基地名が表示されている' do
        expect(page).to have_content army_request.base
      end
      it '階級が表示されている' do
        expect(page).to have_content army_request.army_class
      end
      it '職種が表示されている' do
        expect(page).to have_content army_request.occupation
      end
      it '認識番号が表示されている' do
        expect(page).to have_content army_request.identification_number
      end
    end
    
    context '自衛官申請情報更新成功のテスト' do
      before do
        choose 'customer_army_flag_true'
        click_button '変 更'
      end
      
      it '自衛官ステータスが正しく更新される' do
        expect(page).to have_content '承認'
      end
    end
  end
  
  describe '管理者ログアウトのテスト' do
    before do
      visit new_admin_session_path
      fill_in 'admin[email]', with: admin.email
      fill_in 'admin[password]', with: admin.password
      click_button 'ログイン'
      click_link 'ログアウト'
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてログアウトリンクが存在しない' do
        expect(page).not_to have_link nil, href: destroy_admin_session_path
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/admin/sign_in'
      end
    end
  end
end
