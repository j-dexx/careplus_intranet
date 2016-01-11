class ShoutboxesController < ApplicationController

  before_filter :validate_user, :except => [:index, :show]

  # GET /shoutboxes
  def index
    @all_shoutboxes = Shoutbox.where(:shout_id => nil, :display => true, :sale_item => nil, :rumour => nil).order("updated_at DESC").page(params[:page]).per(12)
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  # GET /shoutboxes/1
  def show
    @shoutboxes = Shoutbox.where(:ancestry_depth => 0, :display => true).limit(3).order("updated_at DESC")
    @shoutbox = Shoutbox.find(params[:id])
    @replies  = @shoutbox.descendants.where(:display => true).arrange(:order => :created_at)
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  # GET /shoutboxes/new
  def new
    @shoutboxes = Shoutbox.where(:ancestry => nil).limit(3).order("created_at DESC")
    @shoutbox = Shoutbox.new(:user_id => current_user.id, :parent_id => params[:parent_id])
    @sale_categories = SaleCategory.all
    
    unless params[:sale_category_id].blank?
      @specific_category = SaleCategory.where(:id => params[:sale_category_id]).first
    end
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  # GET /shoutboxes/1/edit
  def edit
    @shoutbox = Shoutbox.find(params[:id])
  
    if @shoutbox.user_id != current_user.id
      redirect_to root_path
    end
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  # POST /shoutboxes
  def create
    @shoutbox = Shoutbox.new(params[:shoutbox])

    if params[:shoutbox][:user_id].to_f == current_user.id
      if @shoutbox.save and @shoutbox.parent
        @shoutbox.root.update_attribute(:updated_at, Time.now)

        # we don't want an email if it's same person having a conversation with themselves
        if @shoutbox.parent.user_id != current_user.id
          ShoutboxMailer.new(@shoutbox).deliver
        end

        redirect_to @shoutbox.root, notice: 'Reply was successfully created.'
      elsif @shoutbox.save
        redirect_to @shoutbox
      else
        render action: "new"
      end
    else
      redirect_to root_path
    end

    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  # PUT /shoutboxes/1
  def update
    unless params[:shoutbox][:shout_id].blank?
      @shoutbox = Shoutbox.find(params[:shoutbox][:shout_id])
    else
      @shoutbox = Shoutbox.find(params[:shoutbox][:id])
    end
    
    


    if params[:shoutbox][:user_id].to_f == current_user.id and params[:shoutbox][:reported] == nil
      
      if @shoutbox.update_attributes(params[:shoutbox])
        
        unless @shoutbox.parent_id.blank?        
          redirect_to @shoutbox.root, notice: 'Update successful.'
        else
          redirect_to @shoutbox, notice: 'Update successful.'
        end
        
      else
        render action: "edit"
      end
    elsif params[:shoutbox][:reported] != nil
      ShoutboxMailer.report(@shoutbox, current_user).deliver
      flash[:notice] = 'Shout reported!'
      @shoutbox.update_attributes(params[:shoutbox])
      redirect_to @shoutbox.root
    else
      redirect_to root_path
    end
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  # DELETE /shoutboxes/1
  def destroy
    #@shoutbox = Shoutbox.destroy(params[:id])
    #@shoutbox.destroy
    redirect_to shoutboxes_url, :notice => 'You can not do this.'
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end
end
