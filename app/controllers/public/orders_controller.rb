class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
  end

  def thanks
  end

  def create
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method )
  end
end

