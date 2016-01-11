module Admin
  class VenuesController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end

    edit_image_for Venue, :image
  
    def index
      unless params[:order].blank?
        @venues = Venue.order(params[:order]).page(params[:page]).per(50)
      else
        @venues = Venue.order("postcode DESC").page(params[:page]).per(50)
      end
    end
    
    def new
      @venue = Venue.new
    end
    
    def create
      @venue = Venue.new(params[:venue])
      if @venue.save
        redirect_to admin_venues_path, :notice => "Venue successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @venue = Venue.find(params[:id])
    end
    
    def update
      @venue = Venue.find(params[:id])
      if @venue.update_attributes(params[:venue])
        redirect_to admin_venues_path, :notice => "Venue successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @venue = Venue.find(params[:id])
      @venue.destroy
      redirect_to admin_venues_path, :notice => "Venue destroyed."
    end
    
  end
end
