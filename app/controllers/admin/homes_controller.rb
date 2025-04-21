class Admin::HomesController < ApplicationController
  # Admin::HomesControllerのtopアクションで、ページネーションを設定する
  def top
    @orders = Order.page(params[:page]).per(10)  # 1ページあたり10件
  end
end
