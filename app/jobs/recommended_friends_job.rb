class RecommendedFriendsJob < ActiveJob::Base
  queue_as :default

  def perform(user,other_users)
    other_users = User.find(other_users)
    UserMailer.recommend_friends(User.find(user),other_users).deliver!
  end
end
