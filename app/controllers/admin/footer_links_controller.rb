module Admin
  class FooterLinksController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end
    def index
      @footer_links = FooterLink.order(:position)
    end
    
    def new
      @footer_link = FooterLink.new
    end
    
    def create
      @footer_link = FooterLink.new(params[:footer_link])
      if @footer_link.save
        redirect_to admin_footer_links_path, :notice => "Footer link successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @footer_link = FooterLink.find(params[:id])
    end
    
    def update
      @footer_link = FooterLink.find(params[:id])
      if @footer_link.update_attributes(params[:footer_link])
        redirect_to admin_footer_links_path, :notice => "Footer link successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @footer_link = FooterLink.find(params[:id])
      @footer_link.destroy
      redirect_to admin_footer_links_path, :notice => "Footer link destroyed."
    end
    
  end
end
