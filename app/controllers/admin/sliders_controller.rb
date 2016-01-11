module Admin
  class SlidersController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end
    edit_image_for Slider, :image
  
    def index
      @sliders = Slider.order(:position)
    end
    
    def new
      @slider = Slider.new
    end
    
    def create
      @slider = Slider.new(params[:slider])
      if @slider.save
        redirect_to admin_sliders_path, :notice => "Slider successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @slider = Slider.find(params[:id])
    end
    
    def update
      @slider = Slider.find(params[:id])
      if @slider.update_attributes(params[:slider])
        redirect_to admin_sliders_path, :notice => "Slider successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @slider = Slider.find(params[:id])
      @slider.destroy
      redirect_to admin_sliders_path, :notice => "Slider destroyed."
    end
    
  end
end
