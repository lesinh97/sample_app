module ApplicationHelper
  def full_title page_title
    base_title = t "main_title"
    page_title.empty? ? base_title : "#{page_title} #{base_title}"
  end

  def bump_user
    @user ||= current_user
  end

  def find_unfollow
    current_user.active_relationships.find_by followed_id: @user.id
  end
end
