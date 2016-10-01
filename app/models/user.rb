class User < ApplicationRecord
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :birthday, presence: true
  validates :gender_cd, presence: true
  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  has_one :profile
  has_many :posts
  has_many :authored_comments, class_name: "Comment", foreign_key: :user_id, dependent: :destroy
  has_many :initiated_likes, class_name: "Like", foreign_key: :user_id, dependent: :destroy

  def name
    "#{first_name} #{last_name}"
  end

  def name=(new_name)
    self.first_name = new_name.split.first
    self.last_name = new_name.split.last
  end

end
