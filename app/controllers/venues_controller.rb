class VenuesController < ApplicationController

  # GET /venues
  def index
    @venues = Venue.where(:display => true).order("name ASC")
    @footer_links = FooterLink.order(:position)
    
    @current_branch = Willow::StaticPage.find_by_name("Venues")
    
    unless @current_branch.blank?
      @root = @current_branch.branch.root
    end
  end
end

