class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user  

  def current_user
    cookie_name = SITE_SETTINGS['Name'] ? "#{SITE_SETTINGS['Name'].downcase.gsub(' ', '_').first(10)}_user_auth_token" : 'user_auth_token'
    @current_user ||= User.find_by_auth_token(cookies[cookie_name]) if cookies[cookie_name]
  end

  def validate_user
    if current_user.nil?
      session[:return_to] = request.original_url
    end
    redirect_to login_path, :error => 'You must sign in to see this content.' unless current_user
  end
  
  def index
    #@shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(1).order("updated_at DESC")
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true, :sale_item => nil, :rumour => nil).limit(1).order("updated_at DESC")
    @sale_items = Shoutbox.where(:shout_id => nil, :display => true, :sale_item => true).limit(1).order("updated_at DESC")
    
    #@events       = Event.where("end_datetime >= ? AND start_datetime <= ? AND display = ?", DateTime.now, DateTime.now + 2.weeks, true).order("start_datetime ASC").limit(2)
    #articlesLimit = 3 - @events.count
    #@articles     = Article.where(:display => true).limit(articlesLimit).order("date DESC")
    #@combined     = @events + @articles    
    
    @staff_benefits = StaffBenefit.where("display = ? and IMAGE is NOT NULL", true).order(:position)
    #@sliders = Slider.where(:display => true).order(:position)
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(4)
    #@footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    
    #@footer_combined = @footer_articles + @footer_events
    
    @footer_links = FooterLink.order(:position)
    
    render :layout => "home"
  end
end
