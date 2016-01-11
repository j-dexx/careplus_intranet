module Admin
  class UsersController < Manticore::ApplicationController

	  authorize_resource
	  rescue_from CanCan::AccessDenied do |exception|
		  flash[:error] = "Access denied."
		  redirect_to manticore.root_path
	  end

    def index
      unless params[:search].blank?
        @users = User.where(["first_name LIKE :search OR last_name LIKE :search", {:search => "#{params[:search]}%"}]).order(params[:order] ||= :first_name).page(params[:page]).per(10)
      else      
        
        unless params[:order].blank?
          @users = User.order(params[:order]).page(params[:page]).per(50)
        else
          @users = User.order("last_name ASC").page(params[:page]).per(50)
        end
      end
    end
    
    def new
      @user = User.new
    end
    
    def create
      @user = User.new(params[:user])
      if @user.save
        redirect_to admin_users_path, :notice => "User successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @user = User.find(params[:id])
    end
    
    def update
      @user = User.find(params[:id])
      if @user.update_attributes(params[:user])
        redirect_to admin_users_path, :notice => "User successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @user = User.find(params[:id])
      @user.destroy
      redirect_to admin_users_path, :notice => "User destroyed."
    end
    
  end
end
