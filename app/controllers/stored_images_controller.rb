class StoredImagesController < ApplicationController

  layout false

  def index
    respond_to do |format|
      format.js { @stored_images = StoredImage.where(["created_at > ?", (Date.today-7.days)]).order('name') }
    end
  end
  
  def new
    @stored_image = StoredImage.new
  end

  def create
    @stored_image = StoredImage.new(params[:stored_image])
    if @stored_image.save
      render :action => 'close'
    else
      render :action => 'new'
    end
  end

end
