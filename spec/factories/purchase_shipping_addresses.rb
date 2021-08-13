FactoryBot.define do
  factory :purchase_shipping_address do
    postal_code           { '123-4567' }
    prefecture_id         { 2 }
    city                  { '高松市' }
    address               { '1-1' }
    building_name         { '讃岐ビル' }
    phone_number          { '08012345678' }
  end
end
