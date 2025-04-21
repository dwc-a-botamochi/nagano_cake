class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = Addresse.all
    @addresse = Addresse.new
  end

  def edit
    @addresse = Addresse.find(params[:id])
  end

  def create
    Addresse.new(addresse_params).save
    redirect_to action: 'index'
  end

  def update
    Addresse.find(params[:id]).update(addresse_params)
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