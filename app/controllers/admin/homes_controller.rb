class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  # Admin::HomesControllerのtopアクションで、ページネーションを設定する
  def top
    @orders = Order.page(params[:page])
  end
end