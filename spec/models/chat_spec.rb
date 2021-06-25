require 'rails_helper'

RSpec.describe 'Chatモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { chat.valid? }

    let(:chat) { create(:chat) }

    context 'messageカラム' do
      it '空欄でないこと' do
        chat.message = ''
        is_expected.to eq false
      end
    end
  end
end