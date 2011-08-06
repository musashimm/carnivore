require 'yaml'

class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :load_defaults
  helper_method :admin?

  ###################################### protected section #######################################

	protected

	def load_defaults
		$defaults ||= YAML::load(File.open(Rails.root.join('config','defaults.yml')))
	end

	#################################### private section #########################################

	private

  	def get_all_categories
		return Category.find(:all,:order => 'name ASC')
  	end

  	def get_articles_from_category(category_id)
 		return Article.find_all_by_category_id(category_id,:order => 'title ASC',:conditions => "published = true and (main is null or main = false)")
	end

   	def get_all_articles
		@articlesp = Article.find(:all,:conditions => {:published => TRUE},:order=>'updated_at DESC,created_at DESC')
		@articlesu = Article.find(:all,:conditions => {:published => FALSE},:order=>'updated_at DESC,created_at DESC')
   	end

	def get_published_and_main_articles
		@articlem = Article.find(:first,:conditions=>{:main => TRUE,:published => TRUE})
		@articlesp = Article.find(:all,:include=>:category,:conditions=> "published = true and (main is null or main = false)", :order=>'updated_at DESC,created_at DESC',:limit => 10)
	end

	def get_update_time(article)
		if article.nil?
			updatetime=Time.now
		else
			updatetime=(article.updated_at||article.created_at)
		end
		return updatetime.strftime("%Y-%m-%d %H:%M:%S")
	end

	def admin?
  	  session[:username] == $defaults["username"] && session[:password] == $defaults["password"]
  	end

	def authorize
  		unless admin?
    		flash[:error] = "Dostęp zabroniony."
    		redirect_to login_path
    		false
  		end
	end

end
