class Friendship < ActiveRecord::Base

  ##### Associations ####
  belongs_to :user
  belongs_to :friend, :class_name => "User"

  ##### Validations ####

  ##### Methods #####

end
