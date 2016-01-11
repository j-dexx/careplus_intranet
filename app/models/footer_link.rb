class FooterLink < ActiveRecord::Base
  validates :title, :link, :presence => true
  
  #attr_accessible :display, :link, :position, :title
end
