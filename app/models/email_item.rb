class EmailItem < ActiveRecord::Base
  belongs_to :email

  def self.email_item_types
    ['Article']
  end
end
