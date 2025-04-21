class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { not_making: 0, making_pending: 1, making: 2, making_complete: 3 }

  #小計を求めるメソッド
  def subtotal
    price*amount
  end
end
