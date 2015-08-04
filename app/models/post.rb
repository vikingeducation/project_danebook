class Post < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :user

  # ----------------------- Validations --------------------

  validates :user_id, :body,
            :presence => true

end
