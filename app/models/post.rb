class Post < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :user

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, -> { order('created_at ASC') },
            as: :commentable

  # ----------------------- Validations --------------------

  validates :user_id, :body,
            presence: true

  # ----------------------- Methods --------------------

  def liked?
    Like.find_by({likeable_type: 'Post', likeable_id: self.id, user_id: self.user.id })
  end

end
