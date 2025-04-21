class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  validates :payment_method, presence: { message: "を選択してください" }

  #1．enum_helpの導入をする
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum status: { payment_pending: 0, payment_checked: 1, in_making: 2, preparing_shipping: 3, shipped: 4 }
end
