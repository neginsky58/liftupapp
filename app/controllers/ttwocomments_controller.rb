class TtwocommentsController < ApplicationController

  def create
  	@newcomment = Newcomment.find(params[:newcomment_id])
    @ttwocomment = @newcomment.ttwocomments.create!(params[:ttwocomment])
    
    if @ttwocomment.save
      redirect_to newcomment_path(@newcomment), notice: "Comment created."
    end   
  end

  # def show
  #   @ttwocomment = Ttwocomment.find(params[:id])
  # end

  def admin
    if current_user.try(:admin?)
      @ttwocomments = Ttwocomment.newest.page(params[:page]).per_page(20)
    else
      redirect_to root_url
    end
  end

  def destroy
  	@ttwocomment = Ttwocomment.find(params[:id])
    @newcomment = @ttwocomment.newcomment
    @ttwocomment.destroy

    if current_user.try(:admin?)
      redirect_to commentstwo_path
    else
      redirect_to newcomment_path(@newcomment)
    end
  end

end
