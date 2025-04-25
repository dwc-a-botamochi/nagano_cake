class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  before_action :active_check

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    customer = current_customer
    customer.update(customer_params)
    redirect_to action: 'show'
  end

  def check
  end
  
  def withdraw
    current_customer.update(is_active: false)
    sign_out(current_customer)
    redirect_to root_path
  end

  private
  
  def active_check
    unless current_customer.is_active
      sign_out(current_customer)
      redirect_to root_path
    end
  end

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, 
    :post_code, :address, :phone_number, :email)
  end
end