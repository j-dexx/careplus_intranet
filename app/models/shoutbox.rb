class Shoutbox < ActiveRecord::Base
  mount_uploader :image, ShoutboxImageUploader
  
  has_ancestry(:cache_depth => true)

  belongs_to :shout
  belongs_to :user
  belongs_to :sale_category, :counter_cache => true

  validates :title, :message, :presence => true
  #attr_accessible :created, :display, :message, :reported, :title
end
