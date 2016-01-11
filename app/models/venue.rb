class Venue < ActiveRecord::Base
  #attr_accessible :address, :display, :image, :name, :postcode
  
  mount_uploader :image, VenueImageUploader
  
  validates :name, :address, :postcode, :presence => true
end
