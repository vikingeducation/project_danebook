module Commenting

  extend ActiveSupport::Concern

  included do
    has_many :comments, as: :commentable
  end

  def has_comments?
    comments.any?
  end

end
