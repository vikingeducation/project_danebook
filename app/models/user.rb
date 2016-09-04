class User < ApplicationRecord
  before_create :generate_token
  has_secure_password
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :password, :length => { :in => 8..24 },
                       :allow_nil => true

  validates :words_to_live_by, :about, :length => { minimum: 10 }, allow_nil: true
  validates :email, uniqueness: true

  def has_post?
    !self.posts.empty?
  end

  def liked_staff?(staff)
    self.likes.find_by(likeable: staff) ? true : false
  end
end
