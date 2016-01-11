class AwardsController < ApplicationController

  # GET /awards
  def index
    #@awards = Award.where(:display => true)
    @awards_nomination_mode = Award.where("display = ? and mode = ?", true, "nomination")
    @awards_voting_mode     = Award.where("display = ? and mode = ?", true, "voting")
    @awards_awarded         = Award.where("display = ? and mode = ?", true, "awarded")
    
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  def nominate
    @awards_nomination_mode = Award.where("display = ? and mode = ?", true, "nomination")
    #@awards_voting_mode     = Award.where("display = ? and mode = ?", true, "voting")
    
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end
  
  def vote
    #@awards_nomination_mode = Award.where("display = ? and mode = ? and user_id IS NULL", true, "nomination")
    @awards_voting_mode     = Award.where("display = ? and mode = ?", true, "voting")
    
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end
  
  
  def winners
    #@awards_nomination_mode = Award.where("display = ? and mode = ? and user_id IS NULL", true, "nomination")
    @awards_won         = Award.where("display = ? and mode = ?", true, "awarded")
    
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  # GET /awards/1
  def show
    @award = Award.find(params[:id])
    @shoutboxes = Shoutbox.where(:shout_id => nil, :display => true).limit(3).order("updated_at DESC")
    
    @award_nominations = AwardSuggestedNomination.where(:award_id => params[:id]).group_by{|x| x.name.upcase }
    
    @award_suggested_nomination = AwardSuggestedNomination.new
    @award_vote = AwardVote.new
    
    if current_user
      @award_user_nomination = AwardSuggestedNomination.where(:award_id => params[:id], :user_nominated_by_id => current_user.id).limit(1)  
      @award_user_voted = AwardVote.where(:award_id => params[:id], :user_id => current_user.id).limit(1)  
    end
  
    @award_finalised_nominations = AwardNomination.where(:award_id => params[:id])
  
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end
end

