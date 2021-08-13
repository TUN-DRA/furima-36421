class Item < ApplicationRecord
  belongs_to :user
  has_one :purchase
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :prefecture
  belongs_to :days_to_ship

  with_options presence: true do
    validates :image
    validates :product_name
    validates :description
    validates :price,
              numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9_999_999, message: 'out of setting range' }, format: { with: /\A[0-9]+\z/ }
    with_options numericality: { other_than: 1, message: "can't be blank" } do
      validates :category_id
      validates :status_id
      validates :postage_id
      validates :prefecture_id
      validates :days_to_ship_id
    end
  end
end
