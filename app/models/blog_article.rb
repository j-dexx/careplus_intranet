class BlogArticle < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, use: [:slugged]

  mount_uploader :image, BlogArticleUploader

  belongs_to :blog_author
  belongs_to :service
  has_many :blog_article_categorisations, dependent: :destroy
  has_many :blog_categories, through: :blog_article_categorisations

  delegate :name, to: :blog_author, prefix: true, allow_nil: true
  delegate :image, to: :blog_author, prefix: true, allow_nil: true
  delegate :title, to: :service, prefix: true, allow_nil: true

  validates :title, :summary, :content, :date_published, presence: true
end
