module Admin
  class MembersController < Manticore::ApplicationController
  
  edit_image_for Member, :image
  
    def index
      @members = Member.order("`group` asc, `position` asc")
    end
    
    def new
      @member = Member.new
    end
    
    def create
      @member = Member.new(params[:member])
      if @member.save
        redirect_to admin_members_path, :notice => "Member successfully created."
      else
        render :action => 'new'
      end
    end

    def edit
      @member = Member.find(params[:id])
    end
    
    def update
      @member = Member.find(params[:id])
      if @member.update_attributes(params[:member])
        redirect_to admin_members_path, :notice => "Member successfully updated."
      else
        render :action => 'edit'
      end
    end
    
    def destroy
      @member = Member.find(params[:id])
      @member.destroy
      redirect_to admin_members_path, :notice => "Member destroyed."
    end
    
  end
end
