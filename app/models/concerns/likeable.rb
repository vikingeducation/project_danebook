module Likeable
  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable, dependent: :destroy

    attr_readonly :number_of_likes
  end

  # module ClassMethods

  # end

  def liked_by?(user)
    Like.find_by({likeable_type: self.class.to_s, likeable_id: self.id, user_id: user.id })
  end

end