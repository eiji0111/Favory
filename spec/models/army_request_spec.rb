require 'rails_helper'

RSpec.describe 'ArmyRequestモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { army_request.valid? }

    let(:army_request) { create(:army_request) }

    context 'army_typeカラム' do
      it '未選択でないこと' do
        army_request.army_type = ''
        is_expected.to eq false
      end
    end
    
    context 'baseカラム' do
      it '空欄でないこと' do
        army_request.base = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        army_request.base = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        army_request.base = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        army_request.base = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        army_request.base = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'army_classカラム' do
      it '未選択でないこと' do
        army_request.army_class = ''
        is_expected.to eq false
      end
    end
    
    context 'occupationカラム' do
      it '空欄でないこと' do
        army_request.occupation = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        army_request.occupation = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        army_request.occupation = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        army_request.occupation = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        army_request.occupation = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'identification_numberカラム' do
      it '空欄でないこと' do
        army_request.identification_number = ''
        is_expected.to eq false
      end
      it '8文字以上であること: 7文字は×' do
        army_request.identification_number = Faker::Lorem.characters(number: 7)
        is_expected.to eq false
      end
      it '8文字以上であること: 8文字は〇' do
        army_request.identification_number = Faker::Lorem.characters(number: 8)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        army_request.identification_number = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        army_request.identification_number = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'identification_imageカラム' do
      it '未設定でないこと' do
        army_request.identification_image = nil
        is_expected.to eq false
      end
    end
  end
end
