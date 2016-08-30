class UserCommentJob < ActiveJob::Base
  queue_as :default

  def perform(user,resource)
    UserMailer.notify_comment(User.find(user),resource).deliver!
  end
end
