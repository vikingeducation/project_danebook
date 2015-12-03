class Friendship < ActiveRecord::Base
  include Friendable
  # validate friend request exists before create
end
