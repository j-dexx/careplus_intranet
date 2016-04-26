class BlogAuthorsController < ApplicationController
  def index
    @blog_authors = BlogAuthor.where(display: true).order(:name).page(params[:page]).per(10)
  end

  def show
    @blog_author = BlogAuthor.where(display: true).find(params[:id])
    if request.path != blog_authors_path(@blog_author)
      redirect_to blog_authors_path(@blog_author), status: :moved_permanently
    end
  end
end
