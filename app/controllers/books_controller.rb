class BooksController < ApplicationController
  before_action :current_user, only: [:edit, :update]

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
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
    redirect_to book_path(@book.id) #bookの詳細画面に遷移
   else
    render :index
   end
  end

  def show
    @user = current_user
    @newbook = Book.new
    @book = Book.find(params[:id])
  end

  def edit
    @book =Book.find(params[:id])
    redirect_to books_path unless current_user.id == @book.user_id
  end

  def update
    @book =Book.find(params[:id])
    if @book.update(book_params)
       flash[:notice] = 'You have updated book successfully.'
       redirect_to book_path #詳細画面への遷移
    else
       render :edit
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path #一覧画面への遷移
  end

  private

  def book_params
    params.require(:book) .permit(:title, :body)
  end
end
