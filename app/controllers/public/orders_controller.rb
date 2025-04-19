class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
    @order = current_customer.orders.new(order_params)
    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.post_code
      @order.name = "#{current_customer.last_name} #{current_customer.first_name}"
      @order.address = current_customer.address
    elsif params[:order][:select_address] == "1"
      @order.post_code = Address.find(params[:order][:address_id]).post_code
      @order.name = Address.find(params[:order][:address_id]).name
      @order.address = Address.find(params[:order][:address_id]).address
    elsif params[:order][:select_address] == "2"
      @order.post_code = params[:order][:post_code]
      @order.name = params[:order][:name]
      @order.address = params[:order][:address]
    end
    @order.shipping_cost = "800"
    @cart_items = current_customer.cart_items.all
    @cart_items.sum { |item| item.subtotal }
    @order.total_payment = @total + @order.shipping_cost
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

