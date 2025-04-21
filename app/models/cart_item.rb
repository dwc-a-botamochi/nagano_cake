class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item

  #小計を求めるメソッド
  def subtotal
    (item.price * 1.1).floor * amount
  end
end
