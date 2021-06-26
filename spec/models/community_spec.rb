require 'rails_helper'

RSpec.describe 'Communityモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { community.valid? }
    
    let(:customer) { create(:customer) }
    let(:community) { create(:community, owner_id: customer.id) }

    context 'nameカラム' do
      it '空欄でないこと' do
        community.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        community.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        community.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        community.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        community.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'introductionカラム' do
      it '空欄でないこと' do
        community.introduction = ''
        is_expected.to eq false
      end
      it '10文字以上であること: 9文字は×' do
        community.introduction = Faker::Lorem.characters(number: 9)
        is_expected.to eq false
      end
      it '10文字以上であること: 10文字は〇' do
        community.introduction = Faker::Lorem.characters(number: 10)
        is_expected.to eq true
      end
    end
  end
end