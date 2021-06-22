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
end