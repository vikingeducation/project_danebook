module Liking

  extend ActiveSupport::Concern

  included do
    has_many :likes, as: :likeable
  end

  def has_likes?
    likes.any?
  end

  def likes_count
    likes.count
  end

end
