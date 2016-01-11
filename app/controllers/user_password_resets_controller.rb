class UserPasswordResetsController < ApplicationController

  skip_before_filter :validate_user

  def new
    @footer_links = FooterLink.order(:position)
  end
  
  def create
    @footer_links = FooterLink.order(:position)
    
    user = User.find_by_email(params[:username])
    user.send_password_reset if user
    redirect_to login_url, :notice => "Email sent with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token(params[:id])
    @footer_links = FooterLink.order(:position)
  end
  
  def update
    @footer_links = FooterLink.order(:position)
    @user = User.find_by_password_reset_token!(params[:id])  
    if @user.password_reset_sent_at < 4.hours.ago  
      redirect_to(
        new_user_password_reset_path,
        { :alert => "Password reset has expired. Please enter your username and click 'Reset Password' to start again." }
      )
    elsif @user.update_attributes(params[:user])  
      redirect_to login_url, :notice => "Password has been reset."  
    else  
      render :edit  
    end  
  end
   
end
