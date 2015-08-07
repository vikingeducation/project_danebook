module Commentable
  extend ActiveSupport::Concern

  included do
    has_many :comments, -> { order('created_at ASC') },
            as: :commentable
  end

  # module ClassMethods
  # end

end