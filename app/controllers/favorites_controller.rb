class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    fav = current_user.favorites.new(book_id: @book.id)
    fav.save
    # redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    fav = current_user.favorites.find_by(book_id: @book.id)
    fav && fav.destroy # Countermeasures against unauthorized destroy actions
    # redirect_to request.referer
  end
end
