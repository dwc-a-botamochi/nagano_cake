class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def check
    @order = current_customer.orders.new(order_params)
  
    # 住所設定
    if params[:order][:select_address] == "0" # 自身の住所を選択
      @order.post_code = current_customer.post_code
      @order.name = "#{current_customer.last_name} #{current_customer.first_name}"
      @order.address = current_customer.address
    elsif params[:order][:select_address] == "1" # 登録済住所から選択
      selected_address = Address.find(params[:order][:address_id]) # 住所を一度取得して変数に格納
      @order.post_code = selected_address.post_code
      @order.name = selected_address.name
      @order.address = selected_address.address
    elsif params[:order][:select_address] == "2" # 新しいお届け先を入力
      @order.post_code = params[:order][:post_code]
      @order.name = params[:order][:name]
      @order.address = params[:order][:address]
    end
    # 送料を設定
    @order.shipping_cost = "800"
    # カート内商品の合計金額を計算
    @cart_items = current_customer.cart_items.all
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    # 請求金額を計算
    @order.total_payment = @total + @order.shipping_cost
    # 注文を保存して、確認画面に遷移する
    if @order.save
      render :check
    else
      render :new # エラーがあれば、新規注文画面を再表示
    end
  end
  
  def thanks
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.order_id = @order.id
        order_detail.item_id = cart_item.item_id
        order_detail.price = cart_item.item.with_tax_price
        order_detail.amount = cart_item.amount
        order_detail.save
      end
      redirect_to thanks_orders_path
      cart_items.destroy_all
    else
      @order = Order.new
      render :new
    end
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

