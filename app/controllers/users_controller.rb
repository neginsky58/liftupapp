class UsersController < ApplicationController
  def index  
    if current_user.try(:admin?)
      @users = User.newest.page(params[:page]).per_page(10)
    else
      redirect_to root_url
    end
  end

  def show
    if User.find_by_permalink(params[:permalink]).admin == true
      redirect_to root_url
    else
    	@user = User.find_by_permalink(params[:permalink])
    	@projects = @user.projects.approved.newest.page(params[:projects_page]).per_page(5)
      @pendingprojects = @user.projects.pendingsubmission.newest.page(params[:pendingprojects_page]).per_page(5)
      @approvalstage = @user.projects.submittedforapproval.pendingapproval.newest.page(params[:approvalstage_page]).per_page(5)
      @projectsfollowed = @user.followed_projects.newest.page(params[:projectsfollowed_page]).per_page(5)
      @newcomments = @user.newcomments.newest.page(params[:comments_page]).per_page(10)

    end
  end

  def comments
    @user = User.find_by_permalink(params[:permalink])
    @newcomments = @user.newcomments.newest.page(params[:comments_page]).per_page(10)
  end

  def activeprojects
    @user = User.find_by_permalink(params[:permalink])
    @projects = @user.projects.approved.newest.page(params[:projects_page]).per_page(5)
  end

  def pendingprojects
    @user = User.find_by_permalink(params[:permalink])
    @pendingprojects = @user.projects.pendingsubmission.newest.page(params[:pendingprojects_page]).per_page(5)
    @approvalstage = @user.projects.submittedforapproval.pendingapproval.newest.page(params[:approvalstage_page]).per_page(5)
  end

  def projectfollowing
    @user = User.find_by_permalink(params[:permalink])
    @projectsfollowed = @user.followed_projects.newest.page(params[:projectsfollowed_page]).per_page(5)
  end

  def following
    @title = "Following"
    @user = User.find_by_permalink(params[:permalink])
    @users = @user.followed_users.page(params[:page]).per_page(5)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user = User.find_by_permalink(params[:permalink])
    @users = @user.followers.page(params[:page]).per_page(5)
    render 'show_follow'
  end

  def destroy
    @user = User.find(params[:id])

    if @user.destroy
        redirect_to users_url, notice: "User deleted."
    end
  end
end
