class UsersController < ApplicationController
  def index
    @user = current_user
    @book = Book.new
    @users = User.all
  end

  def create
    @book = Book.new(book_params)
    # title,bpdyに入力されたデータを@bookに格納する
    @book.user_id = current_user.id
    # この投稿のuser_idとしてcurrent_user.idの値を代入する
    # current_userはログイン中のユーザーの情報を取得することができる
    @user = current_user
    @books = Book.all
    if @book.save
    flash[:notice] = 'You have created book successfully.'
    redirect_to book_path(book.id) #bookの詳細画面に遷移
    else
    render :index
    end
  end

  def show
    @user = User.find(params[:id])
    @newbook = Book.new
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    redirect_to user_path(current_user) unless current_user.id == @user.id
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = 'You have updated user successfully.'
       redirect_to user_path
    else
       render :edit
    end
  end

  private

  def book_params
    params.require(:book) .permit(:title, :body)
  end
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

end
