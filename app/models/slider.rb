class Slider < ActiveRecord::Base
  mount_uploader :image, SliderImageUploader
  
  validates :headline, :image, :presence => true
  
  #attr_accessible :display, :headline, :image, :link
end
