class AwardNomination < ActiveRecord::Base
  belongs_to :award, :counter_cache => true
  belongs_to :user
  belongs_to :award_suggested_nomination
  has_many :votes, dependent: :destroy
  
  # attr_accessible :title, :body
end
