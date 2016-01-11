module Admin
  class ArticlesController < Manticore::ApplicationController
  
    edit_image_for Article, :image

    authorize_resource
    rescue_from CanCan::AccessDenied do |exception|
	    flash[:error] = "Access denied."
	    redirect_to manticore.root_path
    end
  
    def index
      #@articles = Article.order(params[:order]).page(params[:page]).per(10)
      
      unless params[:order].blank?
        @articles = Article.order(params[:order]).page(params[:page]).per(10)
      else
        @articles = Article.order("date DESC").page(params[:page]).per(10)
      end
      
    end
    
    def new
      @article = Article.new
    end
    
    def create
      @article = Article.new(params[:article])
      if @article.save
        redirect_to admin_articles_path, :notice => "Article successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @article = Article.find(params[:id])
    end
    
    def update
      @article = Article.find(params[:id])
      if @article.update_attributes(params[:article])
        redirect_to admin_articles_path, :notice => "Article successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @article = Article.find(params[:id])
      @article.destroy
      redirect_to admin_articles_path, :notice => "Article destroyed."
    end
    
  end
end
