module Admin
  class AwardSuggestedNominationsController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end

    before_filter {@award = Award.find(params[:award_id])}
  
    def index
      @award_suggested_nominations = AwardSuggestedNomination.where(:award_id => @award.id)      
    end
    
    def new
      @award_suggested_nomination = AwardSuggestedNomination.new(:award_id => @award.id)
    end
    
    def create
      @award_suggested_nomination = AwardSuggestedNomination.new(params[:award_suggested_nomination])
      if @award_suggested_nomination.save
        redirect_to admin_award_award_suggested_nominations_path, :notice => "Award suggested nomination successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @award_suggested_nomination = AwardSuggestedNomination.find(params[:id])
    end
    
    def update
      @award_suggested_nomination = AwardSuggestedNomination.find(params[:id])
      if @award_suggested_nomination.update_attributes(params[:award_suggested_nomination])
        redirect_to admin_award_award_suggested_nominations_path, :notice => "Award suggested nomination successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @award_suggested_nomination = AwardSuggestedNomination.find(params[:id])
      @award_suggested_nomination.destroy
      redirect_to admin_award_award_suggested_nominations_path, :notice => "Award suggested nomination destroyed."
    end
    
  end
end
