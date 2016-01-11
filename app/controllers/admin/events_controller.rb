module Admin
  class EventsController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end
    edit_image_for Event, :image
  
    def index
      @events = Event.order(params[:order])
    end
    
    def new
      @event = Event.new
    end
    
    def create
      @event = Event.new(params[:event])
      if @event.save
        redirect_to admin_events_path, :notice => "Event successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @event = Event.find(params[:id])
    end
    
    def update
      @event = Event.find(params[:id])
      if @event.update_attributes(params[:event])
        redirect_to admin_events_path, :notice => "Event successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @event = Event.find(params[:id])
      @event.destroy
      redirect_to admin_events_path, :notice => "Event destroyed."
    end
    
  end
end
