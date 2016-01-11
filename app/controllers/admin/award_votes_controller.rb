module Admin
  class AwardVotesController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end

    before_filter {@award = Award.find(params[:award_id])}
  
    def index
      @award_votes = AwardVote.where(:award_id => @award.id).order(:nomination_id)
      
      @award_votes_leaderboard =
      AwardVote
      .select(
        'award_votes.*, count(nomination_id) as "nomination_count"'
        )
      .where(:award_id => @award.id).group(:nomination_id).order('nomination_count desc')
    end
    
    def new
      @award_vote = AwardVote.where(:award_id => @award.id)
    end
    
    def create
      @award_vote = AwardVote.new(params[:award_vote])
      if @award_vote.save
        redirect_to admin_award_award_votes_path, :notice => "Award vote successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @award_vote = AwardVote.find(params[:id])
    end
    
    def update
      @award_vote = AwardVote.find(params[:id])
      if @award_vote.update_attributes(params[:award_vote])
        redirect_to admin_award_award_votes_path, :notice => "Award vote successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @award_vote = AwardVote.find(params[:id])
      @award_vote.destroy
      redirect_to admin_award_award_votes_path, :notice => "Award vote destroyed."
    end
    
  end
end
