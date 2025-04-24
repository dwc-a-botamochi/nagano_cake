class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:id])
    @order_details = @order.order_details.all
    is_updated = true
    if @order_detail.update(order_detail_params)
       #製作ステータスを製作中御→注文ステータスを製作中に更新
      @order.update(status: :making) if @order_detail.making_status == "making"
      @order_details.each do |order_detail|
        #製作ステータスが全て製作完了になっていないといけない
        if order_detail.making_status != "making_complete"
          is_updated = false
        end
      end
      #全て製作完了→注文ステータスを発送準備中に更新
      @order.update(status: :making_complete) if is_updated
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
