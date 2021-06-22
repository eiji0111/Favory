require 'rails_helper'

describe '[STEP1] ユーザログイン前のテスト', type: :system do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end
    
    context '表示内容の確認' do
      it 'UPLが正しい' do
        expect(current_path).to eq '/'
      end
      it 'アカウントをお持ちの方はこちら（ログイン）リンクが表示される: 「こちら」のみリンクである' do
        expect(page).to have_link 'こちら'
      end
      it '今すぐはじめる（新規登録）リンクが表示される' do
        expect(page).to have_link '今すぐはじめる'
      end
      it 'お問い合わせリンクが表示される' do
        expect(page).to have_link 'お問い合わせ'
      end
    end
  end
  
  describe 'お問い合わせのテスト' do
    before do
      visit '/contacts/new'
    end
    
    context 'お問い合わせフォーム表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/contacts/new'
      end
      it '「お問い合わせ」と表示される' do
        expect(page).to have_content 'お問い合わせ'
      end
      it 'お名前フォームが表示される' do
        expect(page).to have_field 'contact[name]'
      end
      it 'メールアドレスフォームが表示される' do
        expect(page).to have_field 'contact[email]'
      end
      it 'お問い合わせ内容フォームが表示される' do
        expect(page).to have_field 'contact[content]'
      end
      it '確認画面へボタンが表示される' do
        expect(page).to have_button '確認画面へ'
      end
    end
    
    context 'お問い合わせ確認画面のテスト' do
      before do
        fill_in 'contact[name]', with: 'テストユーザー'
        fill_in 'contact[email]', with: 'test1@example.com'
        fill_in 'contact[content]', with: 'ユーザー間のトラブル解決について'
        click_button '確認画面へ'
      end

      it 'URLが正しい' do
        expect(current_path).to eq '/contacts/confirm'
      end
      it 'お名前が表示される' do
        expect(page).to have_content 'テストユーザー'
      end
      it 'メールアドレスが表示される' do
        expect(page).to have_content 'test1@example.com'
      end
      it 'お問い合わせ内容が表示される' do
        expect(page).to have_content 'ユーザー間のトラブル解決について'
      end
    end
    
    context 'お問い合わせ送信のテスト' do
      before do
        fill_in 'contact[name]', with: 'テストユーザー'
        fill_in 'contact[email]', with: 'test1@example.com'
        fill_in 'contact[content]', with: 'ユーザー間のトラブル解決について'
        click_button '確認画面へ'
        click_button '送信する'
      end
      
      it 'URLが正しい' do
        expect(current_path).to eq '/contacts/complete'
      end
      it '「お問い合わせありがとうございます」と表示される' do
        expect(page).to have_content 'お問い合わせありがとうございます'
      end
    end
  end
  
  describe 'ユーザ新規登録のテスト' do
    before do
      visit new_customer_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_up'
      end
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規登録'
      end
      it 'お名前フォームが表示される' do
        expect(page).to have_field 'customer[name]'
      end
      it 'ニックネームフォームが表示される' do
        expect(page).to have_field 'customer[nickname]'
      end
      it 'メールアドレスフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it '生年月日フォームが表示される' do
        expect(page).to have_field 'customer[birthday(1i)]'
        expect(page).to have_field 'customer[birthday(2i)]'
        expect(page).to have_field 'customer[birthday(3i)]'
      end
      it '性別フォームが表示される' do
        expect(page).to have_field 'customer[sex]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end
    
    context '新規登録成功のテスト' do
      before do
        fill_in 'customer[name]', with: 'テストユーザー'
        fill_in 'customer[nickname]', with: 'てすとゆーざー'
        select '1995', from: 'customer_birthday_1i'
        select '1', from: 'customer_birthday_2i'
        select '11', from: 'customer_birthday_3i'
        choose 'customer_sex_woman'
        fill_in 'customer[email]', with: 'test1@example.com'
        fill_in 'customer[password]', with: 'password'
      end

      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change(Customer.all, :count).by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/customers/' + Customer.last.id.to_s
      end
    end
  end
  
  describe 'ユーザログイン' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it 'メールアドレスフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'パスワードフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、ログインしたユーザの詳細画面になっている' do
        expect(current_path).to eq '/customers/' + customer.id.to_s
      end
    end
    
    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[email]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end
  
  describe 'ヘッダーのテスト: ログインしている場合' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end

    context 'ヘッダーの表示を確認' do
      it '通知アイコンが表示される' do
        expect(page).to have_link nil, href: notifications_path
      end
      it 'ログアウトアイコンが表示される' do
        expect(page).to have_link nil, href: destroy_customer_session_path
      end
    end
    
    context 'フッターの表示を確認' do
      it '男性会員一覧アイコンが表示される' do
        expect(page).to have_link nil, href: customer_men_path
      end
      it '女性会員一覧アイコンが表示される' do
        expect(page).to have_link nil, href: customer_women_path
      end
      it 'コミュニティアイコンが表示される' do
        expect(page).to have_link nil, href: communities_path
      end
      it 'お気に入り一覧アイコンが表示される' do
        expect(page).to have_link nil, href: followed_path
      end
      it 'マイページアイコンが表示される' do
        expect(page).to have_link nil, href: customer_path(customer.id)
      end
    end
  end
  
  describe 'ユーザログアウトのテスト' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
      click_link href: destroy_customer_session_path
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている: ログアウト後のリダイレクト先においてログアウトリンクが存在しない' do
        expect(page).to_not have_link nil, href: destroy_customer_session_path
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end