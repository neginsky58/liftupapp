class ProjectcostsController < ApplicationController
  before_filter :authenticate_user!

  def create
    @project = Project.find(params[:project_id])
    @projectcost = @project.projectcosts.create!(params[:projectcost])
    redirect_to editprojectcosts_project_path(@project)
  end

  def edit
    if current_user == Projectcost.find(params[:id]).project.user
      @projectcost = Projectcost.find(params[:id])
    else
      redirect_to root_url
    end
  end

  def update
    @projectcost = Projectcost.find(params[:id])

    respond_to do |format|
      if @projectcost.update_attributes(params[:projectcost])
        format.html { redirect_to editprojectcosts_project_path(@projectcost.project), notice: 'Project was successfully updated.' }  
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @projectcost.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @projectcost = Projectcost.find(params[:id])
    @projectcost.destroy

    respond_to do |format|
      format.html { redirect_to editprojectcosts_project_path(@projectcost.project) }
      format.json { head :no_content }
    end
  end
  
end