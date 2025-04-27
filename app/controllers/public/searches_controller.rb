class Public::SearchesController < ApplicationController
  def genre_search
    @genre_id = params[:genre_id]
    @items = Item.where(is_active: true).where(genre_id: @genre_id)
      .order(created_at: :desc).page(params[:page]).per(8)
    @genres = Genre.all
  end
end