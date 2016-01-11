class MembersController < ApplicationController

  # GET /members
  def index
    @members = Member.where(:display => true).order("`group` asc, `position` asc")
    @member_roles = @members.group_by{|member| member.group}
  end

  # GET /members/1
  #def show
  #  @member = Member.find(params[:id])
  #end
end

