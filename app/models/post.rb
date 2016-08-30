class Post < ActiveRecord::Base

  scope :desc, -> { order(created_at: :desc) }
  
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :likes, as: :likeable, dependent: :destroy

  accepts_nested_attributes_for :comments, :likes, allow_destroy: true

  validates :body, presence: true, length: { in: 10..20000 }
  # validates :title, length: { in: 4..60 }

  def liked?(user=nil)
    if user
      target = user.id
      likes.where(user_id: target).any?
    else
      likes.any?
    end
  end

  def like(user=nil)
    output = user ? likes.where(user_id: user.id) : likes
    output.last
  end

end
