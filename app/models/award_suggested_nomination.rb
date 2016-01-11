class AwardSuggestedNomination < ActiveRecord::Base
  belongs_to :award, :counter_cache => true
  belongs_to :user_nominated, :class_name => "User", :foreign_key => "user_nominated_id"
  belongs_to :user_nominated_by, :class_name => "User", :foreign_key => "user_nominated_by_id"
  
  validates :name, :telephone, :email, :presence => true, :if => "user_nominated_id.blank?"
  validates :user_nominated_id, :presence => true, :if => "name.blank? and telephone.blank? and email.blank?"
  validates :reason, :presence => true
  # attr_accessible :title, :body
end
