module Admin
  class AwardsController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end

    edit_image_for Award, :image
  
    def index
      @awards = Award.order(params[:order] || "created_at desc").page(params[:page]).per(10)
    end
    
    def new
      @award = Award.new
    end
    
    def create
      @award = Award.new(params[:award])
      if @award.save
        redirect_to admin_awards_path, :notice => "Award successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @award = Award.find(params[:id])
    end
    
    def update
      @award = Award.find(params[:id])
      
      #unless @award.user_id.blank?
        #params[:award][:mode] = 'Awarded'
        #AwardMailer.new(@award).deliver
      #end
      
      if @award.update_attributes(params[:award])
        unless @award.award_suggested_nomination.blank?
          unless @award.award_suggested_nomination.user_nominated.blank?
            AwardMailer.new(@award).deliver
          end
        end
        
        redirect_to admin_awards_path, :notice => "Award successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @award = Award.find(params[:id])
      @award.destroy
      redirect_to admin_awards_path, :notice => "Award destroyed."
    end
    
  end
end
