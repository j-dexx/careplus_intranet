class AwardNominationsController < ApplicationController

  # GET /award_nominations
  def index
    @award_nominations = AwardNomination.all
  end

  # GET /award_nominations/1
  def show
    @award_nomination = AwardNomination.find(params[:id])
  end

  # GET /award_nominations/new
  def new
    @award_nomination = AwardNomination.new
  end

  # GET /award_nominations/1/edit
  def edit
    @award_nomination = AwardNomination.find(params[:id])
  end

  # POST /award_nominations
  def create
    @award_nomination = AwardNomination.new(params[:award_nomination])
    if @award_nomination.save
      redirect_to @award_nomination, notice: 'Award nomination was successfully created.'
    else
      render action: "new"
    end
  end

  # PUT /award_nominations/1
  def update
    @award_nomination = AwardNomination.find(params[:id])
    if @award_nomination.update_attributes(params[:award_nomination])
      redirect_to @award_nomination, notice: 'Award nomination was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /award_nominations/1
  def destroy
    @award_nomination = AwardNomination.find(params[:id])
    @award_nomination.destroy
    redirect_to award_nominations_url, :notice => 'Award nomination destroyed.'
  end
end

