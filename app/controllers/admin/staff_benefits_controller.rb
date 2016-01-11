module Admin
  class StaffBenefitsController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end
    edit_image_for StaffBenefit, :image
  
    def index
      @staff_benefits = StaffBenefit.order(:position)
    end
    
    def new
      @staff_benefit = StaffBenefit.new
    end
    
    def create
      @staff_benefit = StaffBenefit.new(params[:staff_benefit])
      if @staff_benefit.save
        redirect_to admin_staff_benefits_path, :notice => "Staff benefit successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @staff_benefit = StaffBenefit.find(params[:id])
    end
    
    def update
      @staff_benefit = StaffBenefit.find(params[:id])
      if @staff_benefit.update_attributes(params[:staff_benefit])
        redirect_to admin_staff_benefits_path, :notice => "Staff benefit successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @staff_benefit = StaffBenefit.find(params[:id])
      @staff_benefit.destroy
      redirect_to admin_staff_benefits_path, :notice => "Staff benefit destroyed."
    end
    
  end
end
