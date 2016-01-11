class UserSessionsController < ApplicationController  

  skip_before_filter :validate_user, :only => [:new, :create]

  def new
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end
  
  def create
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
    
    cookie_name = SITE_SETTINGS['Name'] ? "#{SITE_SETTINGS['Name'].downcase.gsub(' ', '_').first(10)}_user_auth_token" : 'user_auth_token'
    user = User.where(:email => params[:username]).first
    if user && user.authenticate(params[:password])
      
      if params[:remember_me]
        cookies.permanent[cookie_name] = user.auth_token
      elsif user.active_user == true
        cookies[cookie_name] = user.auth_token
      end      
      
      if session[:return_to].present? and user.active_user == true
        return_url = session[:return_to]
        session.delete(:return_to)
        redirect_to return_url
      elsif user.active_user == true
        redirect_to root_url, notice: "Logged in!"
      else
        redirect_to root_url, notice: "Your account is suspended!"
      end
      
    else
      flash.now.alert = "Invalid username or password"
      render "new"
    end  
  end  
  
  def destroy
    cookie_name = SITE_SETTINGS['Name'] ? "#{SITE_SETTINGS['Name'].downcase.gsub(' ', '_').first(10)}_user_auth_token" : 'user_auth_token'
    cookies.delete(cookie_name)
    redirect_to root_url, :notice => "Logged out!"  
  end
  
end
