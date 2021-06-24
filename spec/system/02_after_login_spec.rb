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
      it '会員のニックネームが表示されている' do
        expect(page).to have_content customer.nickname
      end
      it '自衛官認証申請ボタンが表示されている' do
        expect(page).to have_link "自衛官認証申請"
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