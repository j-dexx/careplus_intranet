class SaleCategoriesController < ApplicationController

  # GET /sale_categories
  def index
    @sale_categories = SaleCategory.all
    
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    
    @recent_sales = Shoutbox.where(:shout_id => nil, :display => true, :sale_item => true).limit(3).order("item_sold asc, updated_at DESC")
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  # GET /sale_categories/1
  def show
    @sale_category = SaleCategory.find(params[:id])
    
    @all_shoutboxes = Shoutbox.where(:shout_id => nil, :display => true, :sale_category_id => params[:id]).order("item_sold asc, updated_at DESC").page(params[:page]).per(12)
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end
end

