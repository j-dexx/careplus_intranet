class StaffSuggestion

	include ActiveModel::Validations
	include ActiveModel::Conversion
  extend  ActiveModel::Naming
  
  attr_accessor :email, :suggested, :name
  
  validates :name, :suggested, :presence => true
  validates :email, :presence => true, :email => true
  
  def initialize(attributes = {})
		#raise attributes.to_yaml
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  	
  def persisted?
    false
  end
    
end
