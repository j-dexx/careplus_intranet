class StaffBenefit < ActiveRecord::Base
  mount_uploader :image, StaffBenefitImageUploader
  
  validates :title, :image, :details, :presence => true
  
  #attr_accessible :display, :image, :link, :title
end
