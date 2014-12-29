class BooksDatatable
  delegate :params, :link_to, :url_for, :check_box_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      sType: 'html',
      iTotalRecords: Book.count,
      iTotalDisplayRecords: books.total_entries,
      aaData: data
    }
  end

private

  def data
    books.map do |book|
      [
        link_to(book.author.name, url_for({ controller: "books", action: "index", author_id: book.author.id })),
        link_to(book.title, book),
        book.cover.exists?(:medium) ? "<a href='#{book.cover.url(:medium)}' target='_blank'><i class='glyphicon glyphicon-picture'></i></a>" : "",
        book.year,
        link_to(book.category.name, url_for({ controller: "books", action: "index", category_id: book.category.id })),
        "#{check_box_tag('books[]', book.id)}",
        link_to('', book, method: :delete, data: { confirm: 'Are you sure?' }, class: "glyphicon glyphicon-trash")
      ]
    end
  end

  def books
    @books ||= fetch_books
  end

  def fetch_books
    books = Book.order("#{sort_column} #{sort_direction}")
    books = books.where(:category_id => params[:category_id]) if params[:category_id].present?
    books = books.where(:author_id => params[:author_id]) if params[:author_id].present?
    books = books.page(page).per_page(per_page)
    if params[:search][:value].present?
      books = books.includes(:author).where("title like :search or authors.name like :search", search: "%#{params[:search][:value]}%")
    end
    books
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[author_id title year category_id]
    columns[params[:order]["0"][:column].to_i]
  end

  def sort_direction
    params[:order]["0"][:dir] == "desc" ? "desc" : "asc"
  end
end

