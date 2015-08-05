class Post < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :author,           foreign_key: :author_id,
                                class_name: "User"
  belongs_to :recipient_user,   foreign_key: :recipient_user_id,
                                class_name: "User"

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, -> { order('created_at ASC') },
            as: :commentable

  # ----------------------- Validations --------------------

  validates :author_id, :recipient_user_id, :body,
            presence: true

  # ----------------------- Methods --------------------

  def liked?
    Like.find_by({likeable_type: 'Post', likeable_id: self.id, user_id: self.author.id })
  end

end
