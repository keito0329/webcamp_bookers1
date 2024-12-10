class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    # １.&2. データを受け取り新規登録するためのインスタンス作成
    @book = Book.new(book_params)
    # 3. データをデータベースに保存するためのsaveメソッド実行
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id]) # 既存のデータを編集するためのインスタンス作成
  end

  def update
    book = Book.find(params[:id]) # 既存のデータを編集するためのインスタンス作成
    if book.update(book_params) # データをデータベースに保存するためのupdateメソッド実行
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(book.id) # トップ画面へリダイレクト
    else
      @book = book
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id]) # 既存のデータを削除するためのインスタンス作成
    book.destroy # データをデータベースから削除するためのdestroyメソッド実行
    redirect_to '/books' # トップ画面へリダイレクト
  end

  private
  # ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end

end
