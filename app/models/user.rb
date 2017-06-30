class User < ApplicationRecord
  before_create :generate_token

  # -----------------------------------------------------------------
  # Associations
  # -----------------------------------------------------------------

  has_one :profile, inverse_of: :user
  has_many :posts
  has_many :likes
  has_many :photos

  has_many :initiated_friend_requests,
           :foreign_key => :user_one_id,
           :class_name => "FriendRequest"

  has_many :received_friend_requests,
           :foreign_key => :user_two_id,
           :class_name => "FriendRequest"

  # -----------------------------------------------------------------
  # Validations
  # -----------------------------------------------------------------

  validates :password,
            ## http://quickleft.com/blog/rails-tip-validating-users-with-has_secure_password
            length: {minimum: 8},
            allow_nil: true

  # -----------------------------------------------------------------
  # Misc
  # -----------------------------------------------------------------

  has_secure_password
  accepts_nested_attributes_for :profile,
                                reject_if: :all_blank,
                                allow_destroy: :true

  # -----------------------------------------------------------------
  # Methods
  # -----------------------------------------------------------------

  def generate_token
    begin
      self[:auth_token] = SecureRandom.urlsafe_base64
    end while User.exists?(:auth_token => self[:auth_token])
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def full_name
    self.profile.first_name + " " + self.profile.last_name
  end

  def friends
    status = Status.find_by(message: "Accepted")
    User.find_by_sql [
    "SELECT u1.id
      FROM users u1
      JOIN friend_requests f ON u1.id = f.user_one_id
      JOIN users u2 ON u2.id = f.user_two_id
      WHERE u2.id = ?
        AND f.status_id = ?
      UNION
      SELECT u1.id
        FROM users u1
        JOIN friend_requests f ON u1.id = f.user_two_id
        JOIN users u2 ON u2.id = f.user_one_id
        WHERE u2.id = ?
          AND status_id = ?", self.id, status.id, self.id, status.id
    ]
  end

  def relationship_with(user_id)
    FriendRequest.relationship_between(self.id, user_id)
  end

  def friends_with?(user_id)
    FriendRequest.friends?(self.id, user_id)
  end

  def self.search(param)
    User.find_by_sql [
      "SELECT u.*
        FROM users u
        JOIN profiles p ON u.id = p.user_id
        WHERE (p.first_name ILIKE :param) OR (p.last_name ILIKE :param)",
      param: "%#{param}%"
    ]
  end

end
