class AwardSuggestedNominationsController < ApplicationController

  # GET /award_suggested_nominations
  def index
    @award_suggested_nominations = AwardSuggestedNomination.all
  end

  # GET /award_suggested_nominations/1
  def show
    @award_suggested_nomination = AwardSuggestedNomination.find(params[:id])
  end

  # GET /award_suggested_nominations/new
  def new
    @award_suggested_nomination = AwardSuggestedNomination.new
  end

  # GET /award_suggested_nominations/1/edit
  def edit
    @award_suggested_nomination = AwardSuggestedNomination.find(params[:id])
  end

  # POST /award_suggested_nominations
  def create
    @award_suggested_nomination = AwardSuggestedNomination.new(params[:award_suggested_nomination])
    @award = Award.find(@award_suggested_nomination.award_id)
    
    if params[:award_suggested_nomination][:user_nominated_by_id].to_f == current_user.id      
      if @award_suggested_nomination.save
        AwardSuggestedNominationMailer.new(@award, @award_suggested_nomination).deliver
        redirect_to award_path(@award_suggested_nomination.award_id), notice: 'Award suggested nomination was successfully created.'
      else
        render action: "new"
      end
    
    else  
      redirect_to root_path      
    end
  end

  # PUT /award_suggested_nominations/1
  def update
    @award_suggested_nomination = AwardSuggestedNomination.find(params[:id])
    if @award_suggested_nomination.update_attributes(params[:award_suggested_nomination])
      redirect_to @award_suggested_nomination, notice: 'Award suggested nomination was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /award_suggested_nominations/1
  def destroy
    @award_suggested_nomination = AwardSuggestedNomination.find(params[:id])
    @award_suggested_nomination.destroy
    redirect_to award_suggested_nominations_url, :notice => 'Award suggested nomination destroyed.'
  end
end

