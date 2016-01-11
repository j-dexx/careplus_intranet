class AwardSuggestedNominationMailer < ActionMailer::Base
  default :from => "careplus@eskimosoup.co.uk"
  default :to => SITE_SETTINGS["Award Email"]
  
  def new(award, award_nomination)
    @award = award
    @award_nomination = award_nomination
    
    mail :subject => "New award nomination: #{@award.title}"
  end
  
end
