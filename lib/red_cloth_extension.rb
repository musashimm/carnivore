module RedClothExtension
	@@subdir = ""
	
   def imgdesc(opts)
		alt = ""
		image,alt,desc = opts[:text].split('|').map! {|str| str.strip}
		if alt.length.zero?
			alt = image
		end
		html = %Q{<div class="imgdesc">\n}
		html << '<a class="img" href="/images/articles/'+@@subdir+'/'+image+'" rel="lightbox" title="'+alt+"\">\n"
		if opts[:class] =~ /noframe/
			html << '<img class="noframe" src="/images/articles/'+@@subdir+'/tmb_'+image+'" alt="'+alt+"\"/></a>\n"
		else
			html << '<img class="link" src="/images/articles/'+@@subdir+'/tmb_'+image+'" alt="'+alt+"\"/></a>\n"
		end
		html << %Q{<p>}
		html << desc
		html << %Q{</p>\n}
		html << %Q{</div>\n}
		html << %Q{<div class="clearpicture"></div>\n}
	end

	def imgdescnolink(opts)
		alt = ""
		image,alt,desc = opts[:text].split('|').map! {|str| str.strip}
		if alt.length.zero?
			alt = image
		end
		html = %Q{<div class="imgdescnolink">\n}
		if opts[:class] =~ /noframe/
			html << '<img class="noframe" src="/images/articles/'+@@subdir+'/'+image+'" alt="'+alt+"\"/>\n"
		else
			html << '<img class="link" src="/images/articles/'+@@subdir+'/'+image+'" alt="'+alt+"\"/>\n"
		end
		html << %Q{<p>}
		html << desc
		html << %Q{</p>\n}
		html << %Q{</div>\n}
		html << %Q{<div style="clear: both;"></div>\n}
	end	

	def imglight(opts)
		alt = ""
		image,alt = opts[:text].split('|').map! {|str| str.strip}
		if alt.length.zero?
			alt = image
		end
		html = '<a class="imgl" href="/images/articles/'+@@subdir+'/'+image+'" rel="lightbox" title="'+alt+"\">\n"
		html << '<img class="link" src="/images/articles/'+@@subdir+'/tmb_'+image+'" alt="'+alt+"\"/></a>\n"
	end

	def imglightcollection(opts)
		alt = ""
		image,alt,collection = opts[:text].split('|').map! {|str| str.strip}
		if alt.length.zero?
			alt = image
		end
		html = '<a class="imgl" href="/images/articles/'+@@subdir+'/'+image+'" rel="lightbox['+collection+']" title="'+alt+"\">\n"
		if opts[:class] == 'noframe'
			html << '<img class="noframe" src="/images/articles/'+@@subdir+'/tmb_'+image+'" alt="'+alt+"\"/></a>\n"
		else
			html << '<img class="link" src="/images/articles/'+@@subdir+'/tmb_'+image+'" alt="'+alt+"\"/></a>\n"
		end
	end

	def imgone(opts)
		alt = ""
		image,alt = opts[:text].split('|').map! {|str| str.strip}
		if alt.length.zero?
			alt = image
		end
		html = '<div class="center"><img src="/images/articles/'+@@subdir+'/'+image+'" alt="'+alt+"\"/></div>\n"
	end

	def imgonelight(opts)
		alt = ""
		image,alt = opts[:text].split('|').map! {|str| str.strip}
		if alt.length.zero?
			alt = image
		end
		html = '<div class="center"><a class="imgl" href="/images/articles/'+@@subdir+'/'+image+'" rel="lightbox" title="'+alt+'"><img class="link" src="/images/articles/'+@@subdir+'/tmb_'+image+'" alt="'+alt+"\"/></a></div>\n"
	end

	def moviedesc(opts)
		alt = ""
		tmb,alt,movie,desc = opts[:text].split('|').map! {|str| str.strip}
		if alt.length.zero?
			alt = image
		end
		html = %Q{<div class="imgdesc">\n}
		html << '<a class="imgl" href="/images/articles/'+@@subdir+'/'+movie+'"><img class="link" src="/images/articles/'+@@subdir+'/'+tmb+'"  alt="'+alt+'" title="'+alt+'" /></a>'
		html << %Q{<p>}
		html << desc
		html << %Q{</p>\n}
		html << %Q{</div>\n}
		html << %Q{<div style="clear: both;"></div>\n}
	end

	def movie(opts)
		alt = ""
		image,alt,movie = opts[:text].split('|').map! {|str| str.strip}
		if alt.length.zero?
			alt = image
		end	
		html = '<a class="imgl" href="/images/articles/'+@@subdir+'/'+movie+'"><img class="link" src="/images/articles/'+@@subdir+'/'+image+'" alt="'+alt+"\"/></a>\n"
	end

	def self.setSubDir(subdir)
		@@subdir=subdir.gsub(/-/,"_")
	end

    def linkmore(opts)
		text,link = opts[:text].split('|').map! {|str| str.strip}
		html = '<div class="more">'
		html << '<a href="'+link+'">'+text+'</a>'
		html << '</div>'
	end
 
end
