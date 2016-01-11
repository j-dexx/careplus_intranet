class RumoursController < ApplicationController
  # GET /rumours
  def index
    @all_shoutboxes = Shoutbox.where(:shout_id => nil, :display => true, :rumour => true).order("updated_at DESC").page(params[:page]).per(12)    
  end
end
