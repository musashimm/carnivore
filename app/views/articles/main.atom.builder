atom_feed do |feed|
	feed.title(PORTAL_NAME)
	feed.updated(@articlesp.first.created_at)

	@articlesp.each do |article|
		feed.entry(article, :url => article.permalink ) do |entry|
			entry.title(article.category.name+" - "+article.title)
			entry.content(article.news, :type=>'html')
			entry.author { |author| author.name("todryk.pl") }
		end
	end
end