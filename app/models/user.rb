class User < ApplicationRecord
  has_secure_password

  has_many :posts, dependent: :destroy
  has_many :authored_posts, class_name: :Post

  has_many :likes
  has_many :posts_they_like, through: :likes, source: :likeable, source_type: :Post

  has_many :comments
  has_many :authored_comments, through: :comments, source: :commentable, source_type: :Comment

  validates :name, presence: true

  validates :email,
            presence: true,
            :uniqueness => true,
            :format => { :with => /@/ }

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  def display_name
    name.blank? ? email : name
  end

end
