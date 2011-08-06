# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
	def navigation
 		content_for :navigation do
 			s = raw("<div class=\"navcat\">\n")
			if @category_id.nil? && @login_page != true
				s += link_to content_tag(:span, "Strona Główna"),"/",:class=>'current'
			else
				s += link_to content_tag(:span, "Strona Główna"),"/"
			end
			for category in @categories
				if @category_id == category.id
				ss = link_to content_tag(:span,h(category.name)), "/#{gen_perm(category.name)}" ,:class=>'current'
				else
				ss = link_to content_tag(:span,h(category.name)), "/#{gen_perm(category.name)}"
				end
				s += content_tag(:h1,ss)
			end
 			s += raw("</div>\n")
 			s += raw("<div style=\"clear: both;\"></div>\n")

 			if not @category_id.nil?
				s += raw("<div class=\"navart\">")

				for article in @articles_from_category
					if article.category.name != article.title
						if article.permalink == params[:permalink]
							s += link_to content_tag(:span,h(article.title)), "/#{article.permalink}", :class=>'current'
						else
							s += link_to content_tag(:span,h(article.title)), "/#{article.permalink}"
						end
					end
				end

				s += raw("</div>")
				s += raw("<div style=\"clear: both;\"></div>")
			end
			s
 		end
	end

  def gen_perm(string)
	return string.downcase.gsub(/\W/,'-').gsub(/-+/,'-')
  end

end
