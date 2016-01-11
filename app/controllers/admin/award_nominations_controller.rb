module Admin
  class AwardNominationsController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end

    before_filter {@award = Award.find(params[:award_id])}


  
    def index
      @award_nominations = AwardNomination.where(:award_id => @award.id)
    end
    
    def new
      @award_nomination = AwardNomination.new(:award_id => @award.id)
    end
    
    def create
      @award_nomination = AwardNomination.new(params[:award_nomination])
      if @award_nomination.save
        redirect_to admin_award_award_nominations_path, :notice => "Award nomination successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @award_nomination = AwardNomination.find(params[:id])
    end
    
    def update
      @award_nomination = AwardNomination.find(params[:id])
      if @award_nomination.update_attributes(params[:award_nomination])
        redirect_to admin_award_award_nominations_path, :notice => "Award nomination successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @award_nomination = AwardNomination.find(params[:id])
      @award_nomination.destroy
      redirect_to admin_award_award_nominations_path, :notice => "Award nomination destroyed."
    end
    
  end
end
