class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  has_many :likes, :as => :likeable, :dependent => :destroy

  validates :body,
            :presence => true

  def date
    created_at.strftime('%A, %B %e %Y')
  end
end
