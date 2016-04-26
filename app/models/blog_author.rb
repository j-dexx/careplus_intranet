class BlogAuthor < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged]

  mount_uploader :image, BlogAuthorUploader

  validates :name, presence: true, uniqueness: true
end
