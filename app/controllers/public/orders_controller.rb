class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
    @order = current_customer.orders.new(order_params)
    # 住所情報の設定
    if params[:order][:select_address] == "0"
      @order.post_code = current_customer.post_code
      @order.name = "#{current_customer.last_name} #{current_customer.first_name}"
      @order.address = current_customer.address
    elsif params[:order][:select_address] == "1"
      @order.post_code = Address.find(params[:order][:address_id]).post_code
      @order.name = Address.find(params[:order][:address_id]).name
      @order.address = Address.find(params[:order][:address_id]).address
    elsif params[:order][:select_address] == "2"
      # 新しいお届け先が入力条件に合わない場合、再度入力を行う
      unless @order.post_code.to_s.length == 7 && @order.post_code.to_s.match?(/^[0-9]+$/) && @order.address != "" && @order.name != "" 
        render :new
      end
    end
    # 送料の設定
    @order.shipping_cost = "800"
    # カート情報の設定
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @order.total_payment = @total + @order.shipping_cost
  end
  
  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.price = (cart_item.item.price * 1.1).floor
        order_detail.amount = cart_item.amount
        order_detail.save
      end
      redirect_to thanks_orders_path
      cart_items.destroy_all
    end
  end

  def thanks
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
  end

  private

  def order_params
    params.require(:order).permit(:post_code, :address, :name, :shipping_cost, :total_payment, :payment_method )
  end
end

