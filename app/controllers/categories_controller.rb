class CategoriesController < ApplicationController
  before_filter :set_category, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    respond_to do |format|
      format.html
      format.datatable { render json: CategoriesDatatable.new(view_context) }
    end
  end

  def show
    respond_with(@category)
  end

  def new
    @category = Category.new
    respond_with(@category)
  end

  def edit
  end

  def create
    @category = Category.new(params[:category])
    @category.save
    flash[:notice] = "\"#{@category.name}\" was successfully created." if @category.valid?
    respond_with(@category)
  end

  def update
    @category.update_attributes(params[:category])
    respond_with(@category)
  end

  def destroy
    if @category.books.size.zero?
      @category.destroy
      flash[:alert] = "\"#{@category.name}\" was successfully removed."
    else
      flash[:alert] = "Please remove all books of this category before do this action."
    end
    respond_with(@category)
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end
end
