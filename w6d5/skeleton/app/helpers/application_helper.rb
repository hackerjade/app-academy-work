module ApplicationHelper
  def initFollowState(user)
    current_user.followees.include?(user) ? "followed" : "unfollowed"
  end

end
