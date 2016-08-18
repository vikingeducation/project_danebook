class Activity < ApplicationRecord

  belongs_to :postable, :polymorphic => true, dependent: :destroy
  belongs_to :author, class_name: "User"
  has_many :likes, :as => :likeable, class_name: "Liking"
  has_many :likers, through: :likes, source: :user
  has_many :comments, :as => :commentable

  def create_comment(params, user)
    c = comments.create(params)
    a = Activity.new(author_id: user.id,
    postable_type: "Comment", postable_id: c.id)
    a.save
  end

end
