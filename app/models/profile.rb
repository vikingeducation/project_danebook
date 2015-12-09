class Profile < ActiveRecord::Base
  include Dateable
  include Feedable

  feedable_user_method :user
  feedable_actions :update
  
  belongs_to :user
end
