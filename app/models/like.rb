class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true
  belongs_to :user

  def self.already_liked?(post, user)
    post.likes.pluck(:user_id).include?(user.id)
  end

end
