require 'rails_helper'

RSpec.describe 'Contactモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { contact.valid? }

    let(:contact) { create(:contact) }

    context 'nameカラム' do
      it '空欄でないこと' do
        contact.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        contact.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        contact.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        contact.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        contact.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'emailカラム' do
      it '空欄でないこと' do
        contact.email = ''
        is_expected.to eq false
      end
      it 'emailに@が含まれていない場合お問い合わせできない' do
        contact.email = 'hogehoge.com'
        is_expected.to eq false
      end
    end
    
    context 'contentカラム' do
      it '空欄でないこと' do
        contact.content = ''
        is_expected.to eq false
      end
      it '20文字以上であること: 19文字は×' do
        contact.content = Faker::Lorem.characters(number: 19)
        is_expected.to eq false
      end
      it '20文字以上であること: 20文字は〇' do
        contact.content = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '255文字以下であること: 255文字は〇' do
        contact.content = Faker::Lorem.characters(number: 255)
        is_expected.to eq true
      end
      it '255文字以下であること: 256文字は×' do
        contact.content = Faker::Lorem.characters(number: 256)
        is_expected.to eq false
      end
    end
  end
end