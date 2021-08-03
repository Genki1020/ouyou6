class FavoritesController < ApplicationController
    before_action :authenticate_user!
    def create
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    if favorite.save
        flash[:notice] = "Book was successfully created."
        redirect_to request.referer
    else
        @user = current_user
        flash[:notice] = "Book was errored."
        render request.referer
    end
    end

    def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referer
    end

end
