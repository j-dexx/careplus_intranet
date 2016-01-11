class SaleCategory < ActiveRecord::Base
  attr_accessible :title
  
  has_many :shoutboxes
end
