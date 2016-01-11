module Admin
  class SaleCategoriesController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end
    def index
      @sale_categories = SaleCategory.all
    end
    
    def new
      @sale_category = SaleCategory.new
    end
    
    def create
      @sale_category = SaleCategory.new(params[:sale_category])
      if @sale_category.save
        redirect_to admin_sale_categories_path, :notice => "Sale category successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @sale_category = SaleCategory.find(params[:id])
    end
    
    def update
      @sale_category = SaleCategory.find(params[:id])
      if @sale_category.update_attributes(params[:sale_category])
        redirect_to admin_sale_categories_path, :notice => "Sale category successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @sale_category = SaleCategory.find(params[:id])
      @sale_category.destroy
      redirect_to admin_sale_categories_path, :notice => "Sale category destroyed."
    end
    
  end
end
