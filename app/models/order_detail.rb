class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  #1．enum_helpの導入をする
  enum making_status: { not_making: 0, pending: 1, making: 2, complete: 3 }

  #小計を求めるメソッド
  def subtotal
    price*amount
  end
end
