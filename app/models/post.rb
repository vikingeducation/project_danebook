class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  has_many :likes,    as: :likable,     dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :author,  presence: true
  validates :content, presence: true,
                        length: { maximum: 255 }

  def self.include_post_info
    includes(author: [profile: :photo], likes: :liker,
            comments: [:commentable, author: [profile: :photo],
            likes: :liker])
  end
end
