class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @items = Item.order(created_at: :asc).page(params[:page]).per(10)
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @genres = Genre.all
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @genres = Genre.all

    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render :edit
    end
    
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :price, :genre_id, :is_active)
  end

end
