class Public::HomesController < ApplicationController
  before_action :active_check, only: [:top]
  
  def top
    @items = Item.where(is_active: true).order(created_at: :desc).limit(4)
    @genres = Genre.all
  end

  def about
  end

  private

  def active_check
    unless current_customer.nil?
      unless current_customer.is_active
        sign_out(current_customer)
        redirect_to root_path
      end
    end
  end
end
