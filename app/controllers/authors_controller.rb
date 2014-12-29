class AuthorsController < ApplicationController
  before_filter :set_author, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    respond_to do |format|
      format.html
      format.json { render json: AuthorsDatatable.new(view_context) }
    end
  end

  def show
    respond_with(@author)
  end

  def new
    @author = Author.new
    respond_with(@author)
  end

  def edit
  end

  def create
    @author = Author.new(params[:author])
    @author.save
    flash[:notice] = "\"#{@author.name}\" was successfully created." if @author.valid?
    respond_with(@author)
  end

  def update
    @author.update_attributes(params[:author])
    respond_with(@author)
  end

  def destroy
    if @author.books.size.zero?
      @author.destroy
      flash[:alert] = "\"#{@author.name}\" was successfully removed."
    else
      flash[:alert] = "Please remove all books of this author before do this action."
    end
    respond_with(@author)
  end

  private
    def set_author
      @author = Author.find(params[:id])
    end
end
