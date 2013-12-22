class BloglikesController < ApplicationController
  before_filter :authenticate_user! 

  def create
    @blogupdate = Blogupdate.find(params[:bloglike][:blogupdate_id])
    @project = @blogupdate.project
    current_user.like_blogupdate!(@blogupdate)
    redirect_to blogs_project_path(@project)
  end

  def destroy
    @blogupdate = Bloglike.find(params[:id]).blogupdate
    @project = @blogupdate.project
    current_user.blogupdate_unlike!(@blogupdate)
    redirect_to blogs_project_path(@project)
  end

end



  