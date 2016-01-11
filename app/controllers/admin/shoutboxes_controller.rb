module Admin
  class ShoutboxesController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end
    def index
			
			unless params[:order].blank?
			
				@shoutboxes = Shoutbox.where(:sale_item => nil, :rumour => nil).order(params[:order]).page(params[:page]).per(10)
				@sale_items = Shoutbox.where(:sale_item => true).order(params[:order]).page(params[:page]).per(10)
				@rumours 	  = Shoutbox.where(:rumour => true).order(params[:order]).page(params[:page]).per(10)
      
			else
	
				@shoutboxes = Shoutbox.where(:sale_item => nil, :rumour => nil).order("created_at desc").page(params[:page]).per(10)
		    @sale_items = Shoutbox.where(:sale_item => true).order("created_at desc").page(params[:page]).per(10)
		    @rumours 	  = Shoutbox.where(:rumour => true).order("created_at desc").page(params[:page]).per(10)	
	
			end;	
      
    end
    
    def new
      @shoutbox = Shoutbox.new
    end
    
    def create
      @shoutbox = Shoutbox.new(params[:shoutbox])
      if @shoutbox.save
        redirect_to admin_shoutboxes_path, :notice => "Shoutbox successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @shoutbox = Shoutbox.find(params[:id])
    end
    
    def update
      @shoutbox = Shoutbox.find(params[:id])
      if @shoutbox.update_attributes(params[:shoutbox])
        redirect_to admin_shoutboxes_path, :notice => "Shoutbox successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @shoutbox = Shoutbox.find(params[:id])
      @shoutbox.destroy
      redirect_to admin_shoutboxes_path, :notice => "Shoutbox destroyed."
    end
    
  end
end
