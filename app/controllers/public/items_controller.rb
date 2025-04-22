class Public::ItemsController < ApplicationController
  def index
    @items = Item.where(is_active: true).order(created_at: :desc).page(params[:page]).per(8)
    #Item.where(is_active: true):is_activeがtrueのものだけ並べる
    #order(created_at: :desc):新着順に並べる
    #page(params[:page]):指定されたページ番号のデータ取得
    #per(8):1ページ当たり8件
  end

  def show
    @item = Item.find(params[:id])
  end
end
