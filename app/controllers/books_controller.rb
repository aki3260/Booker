class BooksController < ApplicationController
  def new
  	@book = Book.new
  	@books = Book.all
  end
  def create
    # ストロングパラメーターを使用
    @book = Book.new(list_params)
    # DBへ保存する
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "Book was successfully create"
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
      @book = Book.find(params[:id])
  end
  def update
  	@book = Book.find(params[:id])
    if @book.update(list_params)
    redirect_to book_path(@book.id)
    flash[:notice] = "Book was successfully updated"
  else
    @books = Book.all
    render :edit
  end
  end
  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
    flash[:notice] = "Book was successfully destroy"
  end

  private
  def list_params
  	params.require(:book).permit(:title, :body)
  end
end