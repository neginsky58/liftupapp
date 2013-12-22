class NewcommentsController < ApplicationController
  before_filter :load_commentable, :except => [:admin]
  before_filter :authenticate_user!, only: [:admin]


  def show
    @newcomment = Newcomment.find(params[:id])
    @ttwocomments = @commentable.ttwocomments.newest.page(params[:commentstwo_page]).per_page(5)
  end

  def index
    redirect_to root_url
	# @newcomments = @commentable.newcomments
	# @newcomment = @commentable.newcomments.new
	# @newcomments = @commentable.newcomments.newest.page(params[:page]).per_page(5)
  end

  def admin
    if current_user.try(:admin?)
      @newcomments = Newcomment.newest.page(params[:page]).per_page(10)
    else
      redirect_to root_url
    end
  end


  def create
  	@newcomment = @commentable.newcomments.new(params[:newcomment])
  	
  	if @newcomment.save
  		# redirect_to comments_project_path(@commentable), notice: "Comment created."
      respond_to do |format|
        format.html { redirect_to comments_project_path(@commentable) }
        format.js
      end

  	else
  		render :new
  	end

  end


  def destroy
    if current_user.try(:admin?)
      @newcomment = Newcomment.find(params[:id])
      @commentable = @newcomment.commentable
      @newcomment.destroy

      if @newcomment.destroy
        redirect_to comments_url, notice: "Comment deleted."
      end
    else
      @newcomment = Newcomment.find(params[:id])
      @commentable = @newcomment.commentable
      @newcomment.destroy

      if @newcomment.destroy
        redirect_to comments_project_path(@commentable), notice: "Comment deleted."
      end
    end
  end

  private
  	def load_commentable
  		resource, id = request.path.split('/')[1,2]
  		@commentable = resource.singularize.classify.constantize.find(id)
  	end

end



  # def new
  # 	@newcomment = @commentable.newcomments.new
  # end



