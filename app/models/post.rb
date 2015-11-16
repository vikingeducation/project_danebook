class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :likes, :as => :likeable, :dependent => :destroy

  validates :body,
            :presence => true

  validates :user,
            :presence => true

  def date
    created_at.strftime('%A, %B %e %Y')
  end
end
