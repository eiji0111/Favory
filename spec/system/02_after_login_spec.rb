require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト', type: :system do
  let(:customer) { create(:customer) }
  let!(:community) { create(:community, owner_id: customer.id) }
  
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
end