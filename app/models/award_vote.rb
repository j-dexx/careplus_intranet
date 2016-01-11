class AwardVote < ActiveRecord::Base
  belongs_to :award, :counter_cache => true
  belongs_to :nomination, :class_name => "AwardNomination", :foreign_key => "nomination_id"
  belongs_to :user
  # attr_accessible :title, :body
end
