# テーブル設計

## users テーブル

| Column            | Type   | Options                   |
| ------------------| ------ | ------------------------- |
| nickname          | string | null: false               |
| email             | string | null: false, unique: true |
| encypted_password | string | null: false               |
| last_name         | string | null: false               |
| first_name        | string | null: false               |
| last_name_kana    | string | null: false               |
| first_name_kana   | string | null: false               |
| birthday          |  date  | null: false               |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| user            | references |             |
| product_name    |   string   | null: false |
| description     |    text    | null: false |
| category_id     |   integer  | null: false |
| status_id       |   integer  | null: false |
| postage_id      |   integer  | null: false |
| prefecture_id   |   integer  | null: false |
| days_to_ship_id |   integer  | null: false |
| price           |   integer  | null: false |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column    | Type       | Options     |
| --------- | ---------- | ----------- |
| user      | references |             |
| prototype | references |             |

### Association

- belongs_to :user
- belongs_to :item
- has_one :shipping_address

## shipping_addresses テーブル

| Column          | Type       | Options     |
| --------------- | ---------- | ----------- |
| purchase        | references |             |
| postal_code     |   string   | null: false |
| prefecture_id   |   integer  | null: false |
| city            |   string   | null: false |
| address         |   string   | null: false |
| building_name   |   string   |             |
| phone_number    |   string   | null: false |

### Association

- belongs_to :purchase