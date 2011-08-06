module ArticlesHelper
	def topics
		if @article.category.name == @article.title
			content_for :topics do
			s = content_tag(:h4, "Strony tematyczne")
				if @articles_from_category.nil? == false
					if @articles_from_category.size > 1
					s += "<ul>"
						for article in @articles_from_category
							if not article.permalink == article.category.name.downcase.gsub(/\W/,'-').gsub(/-+/,'-')
								s += content_tag(:li,(link_to article.title,article.permalink))
							end
						end
					s += "</ul>"
					else
						s += "Brak stron tematycznych"
					end
				else
					s += "Brak stron tematycznych"
				end
			s
			end
		end
	end
end

