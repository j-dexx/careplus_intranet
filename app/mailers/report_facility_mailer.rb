class ReportFacilityMailer < ActionMailer::Base
  default :from => "careplus@eskimosoup.co.uk"
  default :to => SITE_SETTINGS["Report Facilities Emails"]
  
  def new(contact)
    @contact = contact
    mail :subject => "Report Facility form completed - #{SITE_SETTINGS['Name']}"
  end  
  
end
