class ReviewCommentsController < ApplicationController
  before_filter :authenticate_user! 

  def create
    if current_user.try(:admin?)
      @project = Project.find(params[:project_id])
      @review_comment = @project.review_comments.create!(params[:review_comment])
      redirect_to edit_project_path(@project)
    else
      @project = Project.find(params[:project_id])
      @review_comment = @project.review_comments.create!(params[:review_comment])
      redirect_to editcomments_project_path(@project)
    end
  end

  def index
    if current_user.try(:admin?)
      @review_comments = ReviewComments.newest.page(params[:page]).per_page(5)
    else
      redirect_to root_url
    end
  end

  def destroy
    @review_comment = ReviewComment.find(params[:id])
    @review_comment.destroy

    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end
  
end
