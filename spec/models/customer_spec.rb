require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { customer.valid? }

    let!(:other_cusotmer) { create(:customer) }
    let(:customer) { build(:customer) }

    context 'nameカラム' do
      it '空欄でないこと' do
        customer.name = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        customer.name = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        customer.name = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        customer.name = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        customer.name = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'nicknameカラム' do
      it '空欄でないこと' do
        customer.nickname = ''
        is_expected.to eq false
      end
      it '2文字以上であること: 1文字は×' do
        customer.nickname = Faker::Lorem.characters(number: 1)
        is_expected.to eq false
      end
      it '2文字以上であること: 2文字は〇' do
        customer.nickname = Faker::Lorem.characters(number: 2)
        is_expected.to eq true
      end
      it '20文字以下であること: 20文字は〇' do
        customer.nickname = Faker::Lorem.characters(number: 20)
        is_expected.to eq true
      end
      it '20文字以下であること: 21文字は×' do
        customer.nickname = Faker::Lorem.characters(number: 21)
        is_expected.to eq false
      end
    end
    
    context 'emailカラム' do
      it '空欄でないこと' do
        customer.email = ''
        is_expected.to eq false
      end
      it 'emailに@が含まれていない場合登録できない' do
        customer.email = 'hogehoge.com'
        is_expected.to eq false
      end
      it '一意性があること' do
        customer.email = other_cusotmer.email
        is_expected.to eq false
      end
    end
    
    context 'passwordカラム' do
      it '空欄でないこと' do
        customer.password = ''
        is_expected.to eq false
      end
      it '6文字以上であること: 5文字は×' do
        customer.password = Faker::Lorem.characters(number: 5)
        is_expected.to eq false
      end
      it '6文字以上であること: 6文字は○' do
        customer.password = Faker::Lorem.characters(number: 6)
        is_expected.to eq true
      end
    end
  end

  # describe 'アソシエーションのテスト' do
  #   context 'Bookモデルとの関係' do
  #     it '1:Nとなっている' do
  #       expect(Customer.reflect_on_association(:books).macro).to eq :has_many
  #     end
  #   end
  # end
end
