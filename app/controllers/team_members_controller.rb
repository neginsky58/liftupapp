class TeamMembersController < ApplicationController
  before_filter :authenticate_user! 

  def create
    @project = Project.find(params[:project_id])
    @team_member = @project.team_members.create!(params[:team_member])
    redirect_to editteam_project_path(@project)
  end

  def edit
    if current_user == TeamMember.find(params[:id]).project.user
      @team_member = TeamMember.find(params[:id])
    else
      redirect_to root_url
    end
  end

  def update
    @team_member = TeamMember.find(params[:id])

    respond_to do |format|
      if @team_member.update_attributes(params[:team_member])
        format.html { redirect_to editteam_project_path(@team_member.project), notice: 'Project was successfully updated.' }  
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team_member.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @team_member = TeamMember.find(params[:id])
    @team_member.destroy

    respond_to do |format|
      format.html { redirect_to editteam_project_path(@team_member.project) }
      format.json { head :no_content }
    end
  end
  
end