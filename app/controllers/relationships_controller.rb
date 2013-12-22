class RelationshipsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :destroy]

  def create
    @user = User.find(params[:relationship][:followed_id])
    current_user.follow!(@user)
    redirect_to show_user_path(@user.permalink)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
    redirect_to show_user_path(@user.permalink)
  end
end