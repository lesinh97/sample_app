class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    load_followed_user
    current_user.follow @user
    format_response
  end

  def destroy
    load_following_user
    current_user.unfollow @user
    format_response
  end

  private

  def load_followed_user
    @user = User.find_by id: params[:followed_id]
    return if @user
    flash_nil_handle
  end

  def load_following_user
    @user = Relationship.find_by(id: params[:id]).followed
    return if @user
    flash_nil_handle
  end

  def flash_nil_handle
    flash.now[:danger] = t ".user_nil"
    redirect_to root_path
  end

  def format_response
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
