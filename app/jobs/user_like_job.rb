class UserLikeJob < ActiveJob::Base
  queue_as :default

  def perform(user,resource)
    UserMailer.notify_like(User.find(user),resource).deliver!
  end
end
