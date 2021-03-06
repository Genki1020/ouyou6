class UsersController < ApplicationController
  before_action :authenticate_user!



  def new
  end

  def create
  end

  def index
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
    render "edit"
    else
    redirect_to user_path(current_user)
    end
  end

  def update
    @user = User.find(params[:id])
    if  @user.update(user_params)
    flash[:notice] = "User was successfully updated."
    redirect_to user_path(@user)
    else
      flash[:notice] = "User was errored."
      render "users/edit"
    end
  end

  def destroy
  end

  def followings
    @followings = @user.following_users
  end

  def followers
    @followers = @user.follower_users
  end

private

  def user_params
    params.require(:user).permit(:name,:introduction, :profile_image)
  end
end
