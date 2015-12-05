class Friendship < ActiveRecord::Base
  include Dateable
  include Friendable
  # validate friend request exists before create
end
