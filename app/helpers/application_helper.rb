module ApplicationHelper
	def full_title(page_title)
		@basic_title = "Ruby on Rails Tutorial Sample App"
		if page_title
			return page_title + " | " + @basic_title
		else
			return @basic_titles
		end
	end
end
