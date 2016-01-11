class EmailsController < ApplicationController

  def show
    @email = Email.find(params[:id])
    #@testimonial = Testimonial.where(:display => true).order("created_at desc").first
    #@events = Event.where(["display = ? AND ((end_date IS NULL AND start_date >= ?) OR (end_date IS NOT NULL AND end_date >= ?))", true, Date.today, Date.today]).limit(3)
    #@business_highlight = BusinessHighlight.where(:display => true).order('date DESC').first
    #@event_gallery = @email.event_gallery || EventGallery.where(:display => true).order(:position).first
    render @email.template.downcase.gsub(' ', '_')
  end

end
