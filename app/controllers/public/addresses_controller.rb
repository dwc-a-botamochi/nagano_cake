class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = Address.all
    @address = Address.new
    @path_url = addresses_path
    @submit_title = "新規登録"
  end

  def edit
    @address = Address.find(params[:id])
    @path_url = address_path
    @submit_title = "変更内容を保存"
  end

  def create
    address = Address.new(address_params)
  	address.customer_id = current_customer.id
  	address.save
    redirect_to action: 'index'
  end

  def update
    address = Address.find(params[:id])
    address.customer_id = current_customer.id
    address.update(address_params)
    redirect_to action: 'index'
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to action: 'index'
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end
end