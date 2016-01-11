class ReportFacility

	include ActiveModel::Validations
	include ActiveModel::Conversion
  extend  ActiveModel::Naming
  
  attr_accessor :email, :message, :name, :telephone, :building_name
  
  validates :message, :presence => true
  
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  	
  def persisted?
    false
  end
    
end
