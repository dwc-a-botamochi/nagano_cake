class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details

  validates :payment_method, :address, :name, presence: true
  validates :post_code, presence: true, length: { is: 7 }, numericality: { only_integer: true }

  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_pending: 0, payment_checked: 1, in_making: 2, preparing_shipping: 3, shipped: 4 }

  # select_addressはデータベースに保存されない仮の属性として定義
  attr_accessor :select_address

end
