class Admin::CustomersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @customers = Customer.page(params[:page])
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    # @customer = Customer.find(params[:id])
    @customer = Customer.new
  end

  def create
    @customer = Customer.new(customers_params)
    if @customer.save
      redirect_to book_path(@book.id)
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to :show
    else
      render :edit
    end
  end

  private
  
  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, 
    :post_code, :phone_number, :email)
  end
end
