class PurchaseShippingAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :item_id, :postal_code, :prefecture_id, :city, :address, :building_name, :phone_number, :token

  extend ActiveHash::Associations::ActiveRecordExtensions

  with_options presence: true do
    validates :item_id
    validates :user_id
    validates :postal_code, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'is invalid. Include hyphen(-)' }
    validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
    validates :city
    validates :address
    validates :phone_number, numericality: { only_integer: true }, format: { with: /\A\d{10,11}\z/ }
    validates :token
  end

  def save
    purchase = Purchase.create(item_id: item_id, user_id: user_id)
    ShippingAddress.create(purchase_id: purchase.id, postal_code: postal_code, prefecture_id: prefecture_id, city: city,
                           address: address, building_name: building_name, phone_number: phone_number)
  end
end
