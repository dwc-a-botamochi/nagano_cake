class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  #1．enum_helpの導入をする
  enum making_status: { production_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3 }

  #小計を求めるメソッド
  def subtotal
    price*amount
  end
end
