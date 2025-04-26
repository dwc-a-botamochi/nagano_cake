class Public::SearchesController < ApplicationController
  def genre_search
    @genre_id = params[:genre_id]
    @items = Item.where(genre_id: @genre_id).page(params[:page]).per(8)
    @genres = Genre.all
  end
end