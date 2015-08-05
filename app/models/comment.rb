class Comment < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :commentable, :polymorphic => true

  has_many :likes, as: :likeable, dependent: :destroy

  belongs_to :author, foreign_key: "author_id",
                      class_name: "User"

  # ----------------------- Validations --------------------

  validates :author_id, :body,
            presence: true

  # ----------------------- Methods --------------------

  def liked?
    Like.find_by({likeable_type: 'Comment', likeable_id: self.id, user_id: self.author.id })
  end

end
