class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :likes, as: :likeable

  validates :body, length: {minimum: 1}
  validates :user_id, presence: true
  validates :commentable_id, presence: true
  validates :commentable_type, presence: true

  validates_uniqueness_of :commentable_id, :scope => [:commentable_type]


  def already_liked_by?(current_user)
    return false unless current_user
    self.likes.where(:user_id => current_user.id).count > 0
  end

end
