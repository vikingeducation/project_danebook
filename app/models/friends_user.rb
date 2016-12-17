class FriendsUser < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  default_scope {
    includes :user
  }

end
