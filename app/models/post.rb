class Post < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :author,           foreign_key: :author_id,
                                class_name: "User"
  belongs_to :recipient_user,   foreign_key: :recipient_user_id,
                                class_name: "User"

  include Likeable

  include Commentable

  # ----------------------- Validations --------------------

  validates :author_id, :recipient_user_id, :body,
            presence: true

  # ----------------------- Methods --------------------

end
