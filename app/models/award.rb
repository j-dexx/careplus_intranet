class Award < ActiveRecord::Base
  #belongs_to :user
  has_many :award_nominations
  belongs_to :award_suggested_nomination
  has_many :votes

  mount_uploader :image, AwardImageUploader
  
  validates :title, :mode, :presence => true
  
  validates :award_suggested_nomination_id, :presence => true, :if => "mode == 'Awarded'"
  
  #attr_accessible :description, :display, :image, :mode, :position, :title
end
