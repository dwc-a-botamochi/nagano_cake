class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  def show
    @customer = current_user
  end

  def edit
    @customer = current_user
  end

  def update
  end

  def check
  end
  
  def withdraw
    @customer = current_user.is_active(params[:is_active])
    if @customer.save
      redirect_to :top
    end
  end

  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, 
    :post_code, :phone_number, :email)
  end
end