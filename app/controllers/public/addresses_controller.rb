class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = Addresse.all
    @addresse = Addresse.new
    @path_url = addresses_path
    @submit_title = "新規登録"
  end

  def edit
    @addresse = Addresse.find(params[:id])
    @path_url = address_path
    @submit_title = "変更内容を保存"
  end

  def create
    addresse = Addresse.new(addresse_params)
  	addresse.customer_id = current_customer.id
  	addresse.save
    redirect_to action: 'index'
  end

  def update
    addresse = Addresse.find(params[:id])
    addresse.customer_id = current_customer.id
    addresse.update(addresse_params)
    redirect_to action: 'index'
  end

  def destroy
    Addresse.find(params[:id]).destroy
    redirect_to action: 'index'
  end

  private

  def addresse_params
    params.require(:addresse).permit(:post_code, :address, :name)
  end
end