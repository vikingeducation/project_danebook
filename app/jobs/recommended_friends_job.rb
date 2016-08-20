class RecommendedFriendsJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    other_users = User.search('',1,user).limit(3)
    UserMailer.recommend_friends(User.find(user),other_users).deliver!
  end
end
