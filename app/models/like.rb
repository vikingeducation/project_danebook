class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true, counter_cache: true
  belongs_to :liker, :class_name => "User"

  # make sure that the user and liked item are real
  validates :liker, :likable, presence: true
  # make sure that likes are only possible for appropriate objects
  validates :likable_type, inclusion: ["Post", "Comment"]
  # a user can only like a thing once
  validates :liker, uniqueness: { scope: :likable }
end
