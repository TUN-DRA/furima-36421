require 'rails_helper'

RSpec.describe PurchaseShippingAddress, type: :model do  
  before do
    user = FactoryBot.create(:user)
    item = FactoryBot.create(:item)
    @purchase_shipping_address = FactoryBot.build(:purchase_shipping_address, user_id: user.id, item_id: item.id)
    sleep 0.3
  end

  describe '商品購入情報の保存' do
    context '商品購入情報が登録できる時' do
      it '必要な情報を適切に入力して「購入」ボタンを押すと、登録ができる' do
        expect(@purchase_shipping_address).to be_valid
      end
      it '建物名は空でも登録できる' do
        @purchase_shipping_address.building_name = ''
        expect(@purchase_shipping_address).to be_valid
      end
    end

    context '商品購入情報が登録できない時' do
      it '郵便番号が空だと登録できない' do
        @purchase_shipping_address.postal_code = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号が半角のハイフンを含んだ正しい形式でないと登録できない' do
        @purchase_shipping_address.postal_code = '1234567'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it '都道府県欄で未選択のidが送られたら登録できない' do
        @purchase_shipping_address.prefecture_id = 1
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '市区町村が空だと登録できない' do
        @purchase_shipping_address.city = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空だと登録できない' do
        @purchase_shipping_address.address = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空だと登録できない' do
        @purchase_shipping_address.phone_number = ''
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁以下だと登録できない' do
        @purchase_shipping_address.phone_number = '01234567'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上だと登録できない' do
        @purchase_shipping_address.phone_number = '012345678901'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が半角数値以外だと登録できない' do
        @purchase_shipping_address.phone_number = '０１２３４５６７８９'
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include('Phone number is invalid')
      end
      it '購入に紐づく商品情報がない場合は登録できない' do
        @purchase_shipping_address.item_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("Item can't be blank")
      end
      it '購入に紐づくユーザー情報がない場合は登録できない' do
        @purchase_shipping_address.user_id = nil
        @purchase_shipping_address.valid?
        expect(@purchase_shipping_address.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
