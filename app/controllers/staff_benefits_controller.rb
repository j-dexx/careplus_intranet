class StaffBenefitsController < ApplicationController

  # GET /staff_benefits
  def index
    @staff_benefits = StaffBenefit.where("display = ?", true).order(:position)
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end

  # GET /staff_benefits/1
  def show
    @staff_benefits = StaffBenefit.where("display = ?", true).order(:position)
    @staff_benefit = StaffBenefit.find(params[:id])
    
    @footer_articles   = Article.where(:display => true).order("date DESC").limit(3)
    @footer_events     = Event.where("end_datetime >= ? AND display = ?", DateTime.now, true).order("start_datetime ASC").limit(3)
    @footer_links = FooterLink.order(:position)
  end
end

