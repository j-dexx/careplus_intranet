class Event < ActiveRecord::Base
  mount_uploader :image, EventImageUploader
  
  validates :name, :summary, :start_datetime, :end_datetime, :content, :image, :presence => true
  
  #attr_accessible :content, :display, :end_datetime, :image, :name, :start_datetime, :summary
end
