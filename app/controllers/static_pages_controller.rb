class StaticPagesController < ApplicationController
  def home
    load_user_post if logged_in?
  end

  def help; end

  def about; end

  def contact; end

  private

  def load_user_post
    @micropost  = current_user.microposts.build
    @feed_items = current_user.feed.paginate page: params[:page]
  end
end
