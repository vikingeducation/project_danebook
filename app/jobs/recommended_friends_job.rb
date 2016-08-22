class RecommendedFriendsJob < ActiveJob::Base
  queue_as :default

  def perform(user_id,other_users_ids)
    other_users = User.find(other_users)
    UserMailer.recommend_friends(User.find(user_id),other_users).deliver!
  end
  
end
