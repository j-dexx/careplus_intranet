module Admin
  class EmailsController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end

    crops_images_for Email, :image

    def index
      @emails = Email.where(
        ["heading LIKE :search OR summary LIKE :search", {:search => "%#{params[:search]}%"}]
      ).order(params[:order]).page(params[:page]).per(10)
    end

    def new
      @email = Email.new(:template => "Newsletter")
    end

    def create
      @email = Email.new(params[:email])
      if @email.save
        redirect_to admin_emails_path, :notice => "Email successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @email = Email.find(params[:id])
    end

    def update
      @email = Email.find(params[:id])
      if @email.update_attributes(params[:email])
        redirect_to admin_emails_path, :notice => "Email successfully updated."
      else
        render :action => 'edit'
      end
    end

    def destroy
      @email = Email.find(params[:id])
      @email.destroy
      redirect_to admin_emails_path, :notice => "Email destroyed."
    end

    def change_template
      if params[:id] == '0'
        @email = Email.new(:template => params[:template])
      else
        @email = Email.find(params[:id])
        @email.template = params[:template]
      end
    end

    def new_item
      @length = params[:length].to_i + 1
      if params[:id] == '0'
        @email = Email.new
        @email_item = EmailItem.new
      else
        @email = Email.find(params[:id])
        @email_item = EmailItem.new(:email_id => @email.id)
      end
    end

    def destroy_item
      @email_item = EmailItem.find(params[:email_item_id])
      @email_item.destroy
    end

    def create_campaign
      @email = Email.find(params[:id])
      @email.create_campaign
      redirect_to admin_emails_path, :notice => "Campaign Created."
    end

    def update_campaign
      @email = Email.find(params[:id])
      @email.update_campaign
      redirect_to admin_emails_path, :notice => "Campaign Updated."
    end

    def send_test
      @email = Email.find(params[:id])
      if @email.send_test
        redirect_to admin_emails_path, :notice => "Campaign Test Sent."
      else
        redirect_to admin_emails_path, :alert => "Campaign Test Sending Failed."
      end
    end

    def send_now
      @email = Email.find(params[:id])
      if @email.send_now
        redirect_to admin_emails_path, :notice => "Campaign Sent."
      else
        redirect_to admin_emails_path, :alert => "Campaign Sending Faile."
      end
    end

  end
end
