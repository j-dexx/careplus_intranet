class Member < ActiveRecord::Base
  mount_uploader :image, MemberImageUploader
  
  validates :first_name, :last_name, :role, :biography, :presence => true
  
  #attr_accessible :biography, :display, :first_name, :image, :last_name, :position, :role
end
