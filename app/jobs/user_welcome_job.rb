class UserWelcomeJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    args.each do |arg|
      UserMailer.welcome(User.find(arg)).deliver!
    end
  end
end
