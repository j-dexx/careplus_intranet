module Admin
  class BlogArticlesController < Manticore::ApplicationController
    before_filter :set_blog_article, only: [:edit, :update, :destroy]
    edit_images_for BlogArticle, [[:image, { index: ['fill', 208, 208], show: ['fit', 459, 9999], newsletter: ['fill', 195, 135] }]]

    def index
      @blog_articles = BlogArticle.all
    end

    def new
      @blog_article = BlogArticle.new
    end

    def create
      @blog_article = BlogArticle.new(blog_article_params)
      if @blog_article.save
        redirect_to admin_blog_articles_path, notice: 'Blog article successfully created.'
      else
        render action: :new
      end
    end

    def edit
    end

    def update
      if @blog_article.update_attributes(blog_article_params)
        redirect_to admin_blog_articles_path, notice: 'Blog article successfully updated.'
      else
        render action: :edit
      end
    end

    def destroy
      @blog_article.destroy
      redirect_to admin_blog_articles_path, notice: 'Blog article destroyed.'
    end

    private

    def set_blog_article
      @blog_article = BlogArticle.find(params[:id])
    end

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def blog_article_params
      params[:blog_article]
    end
  end
end
