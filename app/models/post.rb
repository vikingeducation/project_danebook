class Post < ActiveRecord::Base
  belongs_to :author, class_name: "User"

  has_many :likes,    as: :likable,     dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates :author,  presence: true
  validates :content, presence: true,
                        length: { maximum: 255 }
end
