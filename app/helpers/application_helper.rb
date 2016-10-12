module ApplicationHelper
	def full_title(page_title='')
		@basic_title = "Ruby on Rails Tutorial Sample App"
		if page_title.empty?
			return @basic_titles
		else
			return page_title + " | " + @basic_title
		end
	end
end
