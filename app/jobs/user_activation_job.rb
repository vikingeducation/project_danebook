# class UserActivationJob < ActiveJob::Base
#   queue_as :default
#
#   def perform(id)
#     UserMailer.activation(User.find(id)).deliver!
#   end
# end
