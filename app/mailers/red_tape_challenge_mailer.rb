class RedTapeChallengeMailer < ActionMailer::Base
  default :from => "careplus@eskimosoup.co.uk"
  default :to => SITE_SETTINGS["Red Tape Challenge Email"]
  
  def new(red_tape_challenge)
    @red_tape_challenge = red_tape_challenge
    mail :subject => "Red Tape Challenge form completed - #{SITE_SETTINGS['Name']}"
  end  
  
end
