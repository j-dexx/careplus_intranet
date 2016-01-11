class PagesController < ApplicationController

  def show
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    @page       = Page.where(:display => true).find(params[:id])

    unless @page.branch.blank?
      @current_branch = @page.branch      
    end
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
    render :layout => @page.layout
  end

end
