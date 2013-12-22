class ProjectRelationshipsController < ApplicationController
  before_filter :authenticate_user! 

  def create
    @project = Project.find(params[:project_relationship][:projectuser_id])
    current_user.follow_project!(@project)
    
    respond_to do |format|
      format.html { redirect_to @project }
      format.js
    end
  end

  def destroy
    @project = ProjectRelationship.find(params[:id]).project
    current_user.project_unfollow!(@project)
    
    respond_to do |format|
      format.html { redirect_to @project }
      format.js
    end
  end

end

  #   redirect_to @project
  # end

  # def create
  #   @project = Project.find(params[:project_relationship][:followed_id])
  #   current_user.follow_project!(@project)
  #   redirect_to @project
  # end

  # def destroy
  #   @project = ProjectRelationship.find(params[:id]).followed
  #   current_user.unfollow_project!(@project)
  #   redirect_to @project
  # end


 # before_filter :signed_in_user


  # def create
  #   @project = Project.find(params[:project_relationship][:projectuser_id])
  #   current_user.follow_project!(@project)
  #   redirect_to @project
  # end

  # def destroy
  #   @project = ProjectRelationship.find(params[:id]).followed_project
  #   current_user.unfollow_project!(@project)
  #   redirect_to @project
  # end

  # def create
  #   @project = Project.find(params[:project_relationship][:followed_id])
  #   current_user.follow_project!(@project)
  #   redirect_to @project
  # end

  # def destroy
  #   @project = ProjectRelationship.find(params[:id]).followed
  #   current_user.unfollow_project!(@project)
  #   redirect_to @project
  # end


 # before_filter :signed_in_user

 # @project = Project.find(params[:project_relationship][:projectuser_id])
 # @project = Project.find(params[:projectuser_id])




