class OrderDetail < ApplicationRecord
  belongs_to :item
  belongs_to :order

  enum making_status: { not_making: 0, making_pending: 1, making: 2, making_complete: 3 }

  # 小計を求めるメソッド
  def subtotal
    price*amount
  end

  # 注文済みの各商品の製作ステータスが製作完了か確認
  def making_complete_checked(order_details)
    check = true
    order_details.each do |order_detail| 
      #　製作ステータスが製作完了になっていない場合、ifに入る
      unless order_detail.making_complete?
        check = false
      end
    end
    return check
  end
end
