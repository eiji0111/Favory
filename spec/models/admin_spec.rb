require 'rails_helper'

RSpec.describe 'Adminモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { admin.valid? }

    let(:admin) { create(:admin) }

    context 'emailカラム' do
      it '空欄でないこと' do
        admin.email = ''
        is_expected.to eq false
      end
      it 'emailに@が含まれていない場合は無効' do
        admin.email = 'hogehoge.com'
        is_expected.to eq false
      end
    end
    
    context 'passwordカラム' do
      it '空欄でないこと' do
        admin.password = ''
        is_expected.to eq false
      end
      it '6文字以上であること: 5文字は×' do
        admin.password = Faker::Lorem.characters(number: 5)
        is_expected.to eq false
      end
      it '6文字以上であること: 6文字は○' do
        admin.password = Faker::Lorem.characters(number: 6)
        is_expected.to eq true
      end
    end
  end
end