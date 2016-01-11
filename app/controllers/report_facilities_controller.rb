class ReportFacilitiesController < ApplicationController

	#before_filter {@current_branch = Willow::StaticPage.find_by_name('Contact Us').branch }

	def new
		@report_facility = ReportFacility.new
		
		@footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
	end

	def create
		@report_facility = ReportFacility.new(params[:report_facility])
		
		@footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
		
		if @report_facility.valid?
      ReportFacilityMailer.new(@report_facility).deliver
      redirect_to new_report_facility_path, :notice => "Thank you for sending the report."
    else
      render :action => "new"
    end
	end

end
