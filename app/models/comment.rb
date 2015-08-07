class Comment < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :commentable, :polymorphic => true

  include Commentable

  include Likeable

  belongs_to :author, foreign_key: "author_id",
                      class_name: "User"

  # ----------------------- Validations --------------------

  validates :author_id, :body, :commentable,
            presence: true

  # ----------------------- Methods --------------------

end
