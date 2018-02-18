class Comment < ApplicationRecord

  belongs_to :user

  belongs_to :commentable, :polymorphic => true
  has_many :likes, :as => :likeable, :dependent => :destroy
  has_many :likers, :through => :likes,
                    :source => :user

  validates_presence_of :user

  validates :body,
            :presence => true

end
