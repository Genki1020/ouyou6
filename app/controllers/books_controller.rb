class BooksController < ApplicationController
  before_action :authenticate_user!

  def new
   @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
     if  @book.save
        flash[:notice] = "Book was successfully created."
        redirect_to book_path(@book)
     else
      @books = Book.all
      @user = current_user
      render "books/index"
     end
  end

  def index
     @books = Book.all
     @user = current_user
     @book = Book.new
  end

  def show
     @book = Book.find(params[:id])
     @user = @book.user
     @book_new = Book.new
     @book_comment = BookComment.new
     @book_comments = @book.book_comments.order(created_at: :desc)
  end

  def edit
      @book = Book.find(params[:id])
      if @book.user == current_user
          render "edit"
      else
          redirect_to books_path
      end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book)
    else
    flash[:notice] = "Book was errored."
    render :edit
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
