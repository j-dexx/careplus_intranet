class MainSiteArticle < ActiveRecord::Base
  establish_connection "main_site_#{Rails.env}"
  self.table_name = "articles"

  extend FriendlyId
  friendly_id :title, use: [:slugged, :history]

  mount_uploader :image, MainSiteArticleUploader

  validates :title, :summary, :content, :image, :date_published, :presence => true
end