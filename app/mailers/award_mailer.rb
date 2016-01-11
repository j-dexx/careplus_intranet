class AwardMailer < ActionMailer::Base
  default :from => "careplus@eskimosoup.co.uk"
  default :to => SITE_SETTINGS["Award Email"]
  
  def new(award)
    @award = award
    
    mail :to => @award.award_suggested_nomination.user_nominated.email, :subject => "You've won an award: #{@award.title}"
  end
  
end
