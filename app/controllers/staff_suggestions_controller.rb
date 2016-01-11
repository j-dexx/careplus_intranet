class StaffSuggestionsController < ApplicationController

	#before_filter {@current_branch = Willow::StaticPage.find_by_name('Contact Us').branch }

	def new
		@staff_suggestion = StaffSuggestion.new
		
		@footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
	end

	def create
		#raise params[:staff_suggestion].to_yaml
		@staff_suggestion  = StaffSuggestion.new(params[:staff_suggestion])
		@footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
		if @staff_suggestion.valid?
      StaffSuggestionMailer.new(@staff_suggestion).deliver
      redirect_to new_staff_suggestion_path, :notice => "Thank you for your suggestion."
    else
      render :action => "new"
    end
	end

end
