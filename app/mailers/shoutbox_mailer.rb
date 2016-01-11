class ShoutboxMailer < ActionMailer::Base
  default :from => "careplus@eskimosoup.co.uk"
  default :to => SITE_SETTINGS["Email"]
  
  def new(shout)
    @shout = shout
    
    unless @shout.parent.user.email.blank?
      mail :to => @shout.parent.user.email, :subject => "New reply: #{@shout.title}"
    else
      mail :to => @shout.user.email, :subject => "New reply: #{@shout.title}"
    end
  end
  
  def report(shout, current_user)
    @shout = shout
    @user  = current_user
    
    mail :to => SITE_SETTINGS["Report Email"], :subject => "Shout reported: #{@shout.title}"
  end  
  
end
