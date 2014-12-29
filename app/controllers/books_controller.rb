class BooksController < ApplicationController
  before_filter :set_book, only: [:show, :edit, :update, :destroy]
  respond_to :html

  def index    
  	respond_to do |format|
  		format.html
  		format.json { render json: BooksDatatable.new(view_context) }
  	end
  end

  # def cate
  # end

  def new
    @book = Book.new
    respond_with(@book)
  end

  def create
    @book = Book.new(book_params)
    flash[:notice] = "\"#{@book.title}\" was successfully created." if @book.save
    respond_with(@book)
  end

  def show
    respond_with(@book)
  end

  def edit  
  end

  def update
    @book.update_attributes(params[:book])
    respond_with(@book)
  end

  def destroy
    @book.destroy 
    flash[:notice] = "\"#{@book.title}\" was successfully removed."   
    respond_with(@book)
  end

  # multiple delete books via post method
  def delete
    seleted_books = params[:books]
    Book.destroy(seleted_books)
    flash[:notice] = "Successfully removed: #{seleted_books.size} book(s)."
    # why redirect_to make current user signed out ?
    redirect_to books_path
  end  

  private
    def set_book
      @book = Book.find(params[:id])
    end

    def book_params
      params.require(:book).permit(:title, :year, :author_id, :category_id)
    end
end
