class Post < ActiveRecord::Base

  # ----------------------- Relationships --------------------

  belongs_to :user

  has_many :likes, dependent: :destroy

  # ----------------------- Validations --------------------

  validates :user_id, :body,
            :presence => true

  # ----------------------- Methods --------------------

  def liked?
    Like.find_by({post_id: self.id, user_id: self.user.id })
  end

end
