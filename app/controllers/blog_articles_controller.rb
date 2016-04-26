class BlogArticlesController < ApplicationController
  # GET /articles
  def index
    @chief_executive = BlogAuthor.find_by_chief_executive(true)
    @blog_articles = BlogArticle.where(display: true).order('date_published DESC')
  end

  # GET /articles/1
  def show
    @blog_article = BlogArticle.where(display: true).find(params[:id])
  end
end
