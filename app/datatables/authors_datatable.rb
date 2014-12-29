class AuthorsDatatable
  delegate :params, :link_to, :check_box_tag, to: :@view

  def initialize(view)
    @view = view
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      sType: 'html',
      iTotalRecords: Author.count,
      iTotalDisplayRecords: authors.total_entries,
      aaData: data
    }
  end

private

  def data
    authors.map do |author|
      [
        link_to(author.name, author),
        author.email,
        author.books.size,
        # "#{check_box_tag('authors[]', author.id)}",
        link_to('', author, method: :delete, data: { confirm: 'Are you sure?' }, class: "glyphicon glyphicon-trash")
      ]
    end
  end

  def authors
    @authors ||= fetch_authors
  end

  def fetch_authors
    authors = Author.order("#{sort_column} #{sort_direction}")
    authors = authors.page(page).per_page(per_page)
    if params[:search][:value].present?
      authors = authors.where("name like :search or email like :search", search: "%#{params[:search][:value]}%")
    end
    authors
  end

  def page
    params[:start].to_i/per_page + 1
  end

  def per_page
    params[:length].to_i > 0 ? params[:length].to_i : 10
  end

  def sort_column
    columns = %w[name email]
    columns[params[:order]["0"][:column].to_i]
  end

  def sort_direction
    params[:order]["0"][:dir] == "desc" ? "desc" : "asc"
  end
end

