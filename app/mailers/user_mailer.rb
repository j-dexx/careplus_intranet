class UserMailer < ActionMailer::Base
  default :from => "careplus@eskimosoup.co.uk"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end
end
