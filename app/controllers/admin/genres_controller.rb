class Admin::GenresController < ApplicationController
  before_action :authenticate_admin!

  def index
    @genres = Genre.all
    @genre = Genre.new
  end

  def create
    genre = Genre.new(genre_params)
    genre.save
    @genres = Genre.all
    redirect_to action: 'index'
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
    genre = Genre.find(params[:id])
    genre.update(genre_params)
    @genres = Genre.all
    redirect_to action: 'index'
  end


  private
  
  def genre_params
    params.require(:genre).permit(:name)
  end
end
