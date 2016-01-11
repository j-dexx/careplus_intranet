class RedTapeChallengesController < ApplicationController

	#before_filter {@current_branch = Willow::StaticPage.find_by_name('Contact Us').branch }

	def new
		@red_tape_challenge = RedTapeChallenge.new
		
		@footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
	end

	def create
		#raise params[:staff_suggestion].to_yaml
		@red_tape_challenge  = RedTapeChallenge.new(params[:red_tape_challenge])
		@footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
		if @red_tape_challenge.valid?
      RedTapeChallengeMailer.new(@red_tape_challenge).deliver
      redirect_to new_red_tape_challenge_path, :notice => "Thank you for your suggestion."
    else
      render :action => "new"
    end
	end

end
