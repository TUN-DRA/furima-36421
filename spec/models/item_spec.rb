require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end

  describe '商品情報登録' do
    context '商品情報が登録できる時' do
      it '必要な情報を適切に入力して「出品する」ボタンを押すと、登録ができる' do
        expect(@item).to be_valid
      end
    end

    context '商品情報が登録できない時' do
      it '商品画像が空では登録できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it '商品名が空では登録できない' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Product name can't be blank")
      end
      it '商品の説明が空では登録できない' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'カテゴリー欄で未選択のidが送られたら登録できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Category can't be blank")
      end
      it '商品の状態欄で未選択のidが送られたら登録できない' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Status can't be blank")
      end
      it '配送料の負担欄で未選択のidが送られたら登録できない' do
        @item.postage_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Postage can't be blank")
      end
      it '発送元の地域欄で未選択のidが送られたら登録できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Prefecture can't be blank")
      end
      it '発送までの日数の情報欄で未選択のidが送られたら登録できない' do
        @item.days_to_ship_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Days to ship can't be blank")
      end
      it '価格が空では登録できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it '価格が¥299以下は登録できない' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include('Price out of setting range')
      end
      it '価格が¥10,000,000以上は登録できない' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include('Price out of setting range')
      end
      it '価格が半角数値以外だと登録できない' do
        @item.price = '１０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('Price out of setting range')
      end
    end
  end
end
