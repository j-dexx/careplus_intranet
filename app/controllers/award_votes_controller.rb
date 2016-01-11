class AwardVotesController < ApplicationController

  # GET /award_votes
  def index
    @award_votes = AwardVote.all
  end

  # GET /award_votes/1
  def show
    @award_vote = AwardVote.find(params[:id])
  end

  # GET /award_votes/new
  def new
    @award_vote = AwardVote.new
  end

  # GET /award_votes/1/edit
  def edit
    @award_vote = AwardVote.find(params[:id])
  end

  # POST /award_votes
  def create
    @award_vote = AwardVote.new(params[:award_vote])
    
    if params[:award_vote][:user_id].to_f == current_user.id
      @award_user_voted = AwardVote.where(:award_id => params[:award_vote][:award_id], :user_id => current_user.id).limit(1)  
      
      
      unless @award_user_voted.blank?
        @award_vote = AwardVote.find(@award_user_voted[0].id)
        
        if @award_vote.update_attributes(params[:award_vote])
          redirect_to award_path(@award_vote.award_id), notice: 'Award vote was successfully updated.'
        end
        
      else
        
        if @award_vote.save
          redirect_to award_path(@award_vote.award_id), notice: 'Award vote was successfully created.'
        else
          render action: "new"
        end
        
      end
      
      
    else  
      redirect_to root_path      
    end
  end

  # PUT /award_votes/1
  def update
    @award_vote = AwardVote.find(params[:id])
    
    
    if params[:award_vote][:user_id].to_f == current_user.id      
      if @award_vote.update_attributes(params[:award_vote])
        redirect_to award_path(@award_vote.award_id), notice: 'Award vote was successfully created.'
      else
        render action: "new"
      end
    else  
      redirect_to root_path      
    end
  end

  # DELETE /award_votes/1
  def destroy
    @award_vote = AwardVote.find(params[:id])
    @award_vote.destroy
    redirect_to award_votes_url, :notice => 'Award vote destroyed.'
  end
end

