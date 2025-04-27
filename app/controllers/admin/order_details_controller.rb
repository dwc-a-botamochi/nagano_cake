class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order = Order.find(params[:order_id])
    @order_detail = OrderDetail.find(params[:id])

    if @order_detail.update(order_detail_params)
      if @order_detail.making_complete?
        order_details = @order.order_details
        # order_detailモデルに記載してあるメソッドを呼び出す
        if @order_detail.making_complete_checked(order_details)
          @order.update(status: Order.statuses[:preparing_shipping])
        end
      elsif @order_detail.making?
        @order.update(status: Order.statuses[:in_making])
      end
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end
end
