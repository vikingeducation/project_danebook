class Like < ActiveRecord::Base
  belongs_to :likable, polymorphic: true, counter_cache: true
  belongs_to :user

  # make sure that the user and liked item are real
  validates :user, :likable, presence: true
  # make sure that likes are only possible for appropriate objects
  validates :likable_type, inclusion: ["Post", "Comment"]
  # a user can only like a thing once
  validates :user, uniqueness: { scope: :likable }
end
