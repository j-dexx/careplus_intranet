class StoredDocumentsController < ApplicationController

  layout false

  def index
    respond_to do |format|
      format.js { @stored_documents = StoredDocument.where(["created_at > ?", (Date.today-7.days)]).order('name') }
    end
  end
  
  def new
    @stored_document = StoredDocument.new
  end

  def create
    @stored_document = StoredDocument.new(params[:stored_document])
    if @stored_document.save
      render :action => 'close'
    else
      render :action => 'new'
    end
  end

end
