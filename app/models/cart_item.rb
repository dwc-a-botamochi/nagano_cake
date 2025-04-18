class CartItem < ApplicationRecord
  #商品モデルに has_many :cart_items, dependent: :destroy 追加する！
  belongs_to :customer
  belongs_to :item

  #小計を求めるメソッド
  def subtotal
    item.with_tax_price * amount
  end

end
