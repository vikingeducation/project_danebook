class Like < ApplicationRecord
  belongs_to :initiated_user, class_name: "User", foreign_key: :user_id

  belongs_to :likable, polymorphic: true, counter_cache: true


  def initiated_user_name
    self.initiated_user.name
  end

  def user
    self.initiated_user
  end

  def liked_on
    self.created_at.strftime("Liked a post on %A, %b %d %Y")
  end
end
