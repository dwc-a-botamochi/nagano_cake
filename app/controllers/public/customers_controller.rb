class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    customer = current_customer(customer_params)
    customer.update
    redirect_to action: 'show'
  end

  def check
  end
  
  def withdraw
    customer = current_customer.is_active(params[:is_active])
    customer.save
      redirect_to root_path
    end
  end

  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, 
    :post_code, :address, :phone_number, :email)
  end
end