class CategoriesDatatable
  delegate :params, :link_to, :check_box_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      sType: 'html',
      iTotalRecords: Category.count,
      iTotalDisplayRecords: categories.total_entries,
      aaData: data
    }
  end

private

  def data
    categories.map do |category|
      [
        link_to(category.name, category),
        category.books.size,
        # "#{check_box_tag('categories[]', category.id)}",
        link_to('', category, method: :delete, data: { confirm: 'Are you sure?' }, class: "glyphicon glyphicon-trash")
      ]
    end
  end

  def categories
    @categories ||= fetch_categories
  end

  def fetch_categories
    categories = Category.order("#{sort_column} #{sort_direction}")
    categories = categories.page(page).per_page(per_page)
    if params[:search][:value].present?
      categories = categories.where("name like :search", search: "%#{params[:search][:value]}%")
    end
    categories
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[name]
    columns[params[:order]["0"][:column].to_i]
  end

  def sort_direction
    params[:order]["0"][:dir] == "desc" ? "desc" : "asc"
  end
end

