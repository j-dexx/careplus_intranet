class UsersController < ApplicationController


  before_filter :validate_user, :only => [:edit, :posts, :sales, :update]

  # GET /users
  def index
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    @footer_links = FooterLink.order(:position)

    if !params[:department].blank? and !params[:search].blank?      
      @users = User.where(
                          "department LIKE :department AND (first_name LIKE :search OR last_name LIKE :search) AND active_user = 1",
                          { :department => "%#{params[:department]}%", :search => "%#{params[:search]}%" }
                          ).order("last_name ASC").page(params[:page]).per(10)
    elsif !params[:department].blank? and params[:search].blank?
      @users = User.where(
                          "(department LIKE :department) AND active_user = 1",
                          { :department => "%#{params[:department]}%" }
                          ).order("last_name ASC").page(params[:page]).per(10)
    elsif !params[:search].blank?
      @users = User.where(
                          "(first_name LIKE :search OR last_name LIKE :search) AND active_user = 1",
                          { :search => "%#{params[:search]}%" }
                          ).order("last_name ASC").page(params[:page]).per(10)
    else
      @users = User.where(:active_user => true).order(params[:order].blank? ? "last_name ASC" : params[:order]).page(params[:page]).per(10)
    end
  end
  
  def posts
    @all_posts = Shoutbox.where(:shout_id => nil, :display => true, :sale_item => nil, :rumour => nil, :user_id => current_user.id).order("created_at DESC").page(params[:page]).per(12)
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    @footer_links = FooterLink.order(:position)
  end


  def rumours
    @all_posts = Shoutbox.where(:shout_id => nil, :display => true, :rumour => true, :user_id => current_user.id).order("created_at DESC").page(params[:page]).per(12)
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    @footer_links = FooterLink.order(:position)
  end
  
  def sales
    @all_sales = Shoutbox.where(:shout_id => nil, :display => true, :sale_item => true, :user_id => current_user.id).order("item_sold ASC, created_at DESC").page(params[:page]).per(12)
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    @footer_links = FooterLink.order(:position)
  end

  # GET /users/1
  def show
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    @footer_links = FooterLink.order(:position)
    
    @user   = User.find(params[:id])
    
    #@award_suggested_nomination = AwardSuggestedNomination.where(:user_nominated_id => params[:id], :award => "award")
    #raise @award_suggested_nomination.to_yaml
    @awards = @user.awards.where(:mode => "awarded")
    #Award.where(:display => true, :user_id => params[:id])
    #raise @awards.to_yaml
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    @footer_links = FooterLink.order(:position)
    
    @user = User.find(params[:id])
    
    if params[:id].to_f != current_user.id
      redirect_to root_path
    end
  end

  # POST /users
  def create
    @user = User.new(params[:user])
    if @user.save
      #redirect_to @user, notice: 'User was successfully created.'
      
      if session[:return_to].present?
        return_url = session[:return_to]
        session.delete(:return_to)
      else
        return_url = login_url
      end
      
      redirect_to return_url, notice: "Please login."
      
    else
      render action: "new"
    end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])
    if params[:id].to_f == current_user.id
      if @user.update_attributes(params[:user])
        redirect_to @user, notice: 'User was successfully updated.'
      else
        render action: "edit"
      end
    else
      redirect_to root_path
    end
  end
end

