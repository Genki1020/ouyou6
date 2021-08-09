class BookCommentsController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = @book.id
  if @book_comment.save
    flash[:notice] = "Comment was successfully created."

  else
    @user = current_user
    flash[:notice] = "Comment was errored."
  end
  end

  def destroy
    book = Book.find(params[:book_id])
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to book_path(book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment, :book_id, :user_id)
  end
end
