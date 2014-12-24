module ApplicationHelper

	# return full title for each page
	def full_title(page_title = '')
		base_title = "Book Manager App"
		if page_title.empty?
			base_title
		else
			"#{page_title} | #{base_title}"
		end
	end

	def devise_controller?(controller_name)
		controller_name.include? "devise/"
	end
end
