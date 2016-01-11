class Article < ActiveRecord::Base

  include Rails.application.routes.url_helpers
  mount_uploader :image, ArticleImageUploader

  before_save :create_main_site_article, :if => Proc.new{|x| x.pushed_to_main_site_changed? and x.pushed_to_main_site?}
  
  validates :headline, :summary, :content, :image, :date, :presence => true

  attr_reader :tweet
  def tweet=(string_value)
    @tweet = (string_value == '1')
  end

  def create_main_site_article    
    article = MainSiteArticle.create(:title => headline, :summary => summary, :content => content, :remote_image_url => "#{root_url.chomp("/")}#{image.url}", :date_published => date, :display => true)

    if Rails.env.development?
      path = article.image.path.split("/")
      path = path.delete_if{|x| x == path.last}.join("/")
      `cp -r #{path} /home/share/careplus/public/uploads/article/image/#{article.id}/`
      `rm -rf #{path}`
    else
			path = article.image.path.split("/")
	    path = path.delete_if{|x| x == path.last}.join("/")
	    `cp -r #{path} /home/careplus/current/public/uploads/article/image/#{article.id}/`
	    `rm -rf #{path}`
    end
    
    if @tweet == true
      begin
        Twitter.update("#{ headline } http://www.careplusgroup.org/articles/#{article.id}")
      rescue Twitter::Error => e
        logger.info "Twitter broke due to: #{e}"
      end
    end
    
  end
end
