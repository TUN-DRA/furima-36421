FactoryBot.define do
  factory :item do
    product_name          { 'test' }
    description           { '説明' }
    category_id           { 2 }
    status_id             { 2 }
    postage_id            { 2 }
    prefecture_id         { 2 }
    days_to_ship_id       { 2 }
    price                 { 10_000 }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
