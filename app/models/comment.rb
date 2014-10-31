class Comment < ActiveRecord::Base
  belongs_to :commentable, polymorphic: true
  belongs_to :author, :class_name => "User"

  has_many :likes, as: :likable, dependent: :destroy

  # make sure that the user and commented item are real
  validates :author, :commentable, presence: true
  # make sure that comments are only possible for appropriate objects
  validates :commentable_type, inclusion: ["Post", "Photo"]
  # make sure the comments are brief and present
  validates :content, presence: true,
                      length: { maximum: 140 }
end
