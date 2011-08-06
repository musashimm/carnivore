require 'red_cloth_extension'

class ArticlesController < ApplicationController

	before_filter :authorize, :except => [:main,:show,:catcher]
	before_filter :get_all_articles, :only => [:index,:delcom]
	before_filter :get_published_and_main_articles, :only => [:main]
	layout "application"

  # GET /articles
  # GET /articles.xml
  def index

	@updatetime = get_update_time(@articlesp.first)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articlesp }
    end
  end

  def delcom
	@article = Article.find_by_id(params[:id])
	if (not @article.comments.count.zero?)
		@article.comments.delete_all
	end
	@articles = Article.find(:all)
	flash[:notice] = 'Komentarze do artykułu zostały usunięte.'
	render :action=>'index'
  end

  def new
	@categories = get_all_categories()
    @article = Article.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit
	@categories = get_all_categories()
    @article = Article.find(params[:id])
	@updatetime = get_update_time(@article)
  end

  # POST /articles
  # POST /articles.xml
  def create
	@categories = get_all_categories()
    @article = Article.new(params[:article])
	@article.permalink = @article.title.downcase.gsub(/\W/,'-').gsub(/-+/,'-')

    respond_to do |format|
      if @article.save
        flash[:notice] = 'Artykuł został utworzony'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update
	@categories = get_all_categories()
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes(params[:article])
        flash[:notice] = 'Artykuł został zaktualizowany'
        format.html { render :action => "show"}
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end

  def main

	@categories = get_all_categories()
	@updatetime = get_update_time(@articlesp.first)

	respond_to do |format|
      format.html # index.html.erb
	  format.atom { render :layout => false }
	  #format.php { render :action => "index.html",:layout=> "application.html"  }
    end

  end

 def show
	if params[:permalink]
		@article = Article.find_by_permalink(params[:permalink])
	else
    	@article = Article.find_by_id(params[:id])
	end
	if @article.nil?
		redirect_to :action => 'catcher'
	else
	#raise ActiveRecord::RecordNotFound if @article.nil?
	@categories = get_all_categories()
	@articles_from_category = get_articles_from_category(@article.category_id)
	@category_id=@article.category_id
	@updatetime=(@article.updated_at||@article.created_at).strftime("%Y-%m-%d %H:%M:%S")
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
	end

  end

  def catcher
    flash[:error] = 'Niestety, żądana strona nie istnieje na tej witrynie.'
    redirect_to :action => 'main'
  end

end
