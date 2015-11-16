class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates :body,
            :presence => true

  def date
    created_at.strftime('%A, %B %e %Y')
  end
end
