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
  
  describe '会員一覧のテスト' do
    before do
      visit customer_men_path
    end
    
    context '男性会員一覧画面表示内容の確認' do
      it '絞り込みボタンが表示されている' do
        expect(page).to have_button '絞り込み'
      end
    end
    
    context '男性会員詳細画面表示内容の確認' do
      before do
        click_link href: customer_path(another_man_customer.id)
      end
      
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/' + another_man_customer.id.to_s
      end
      it '会員名が表示されている' do
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
    
    context 'コミュニティ詳細画面でコメントに成功する（Ajax）', js: true do
      before do
        click_link href: community_path(community.id)
        find('#community_post_btn').click
        fill_in 'community_post[content]', with: 'テスト投稿'
        click_button '投稿'
      end
      
      it '投稿内容が正しく表示される' do
        expect(page).to have_content 'テスト投稿'
      end
    end
  end
end