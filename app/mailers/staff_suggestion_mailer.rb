class StaffSuggestionMailer < ActionMailer::Base
  default :from => "careplus@eskimosoup.co.uk"
  default :to => SITE_SETTINGS["Suggestion Email"]
  
  def new(staff_suggestion)
    @staff_suggestion = staff_suggestion
    mail :subject => "Staff suggestion form completed - #{SITE_SETTINGS['Name']}"
  end  
  
end
