module Admin
  class BlogAuthorsController < Manticore::ApplicationController
    before_filter :set_blog_author, only: [:edit, :update, :destroy]
    edit_images_for BlogAuthor, [[:image, { index: ['fill', 150, 150] }]]

    def index
      @blog_authors = BlogAuthor.all
    end

    def new
      @blog_author = BlogAuthor.new
    end

    def create
      @blog_author = BlogAuthor.new(blog_author_params)
      if @blog_author.save
        redirect_to admin_blog_authors_path, notice: 'Blog author successfully created.'
      else
        render action: :new
      end
    end

    def edit
    end

    def update
      if @blog_author.update_attributes(blog_author_params)
        redirect_to admin_blog_authors_path, notice: 'Blog author successfully updated.'
      else
        render action: :edit
      end
    end

    def destroy
      @blog_author.destroy
      redirect_to admin_blog_authors_path, notice: 'Blog author destroyed.'
    end

    private

    def set_blog_author
      @blog_author = BlogAuthor.find(params[:id])
    end

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def blog_author_params
      params[:blog_author]
    end
  end
end
