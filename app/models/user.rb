class User < ActiveRecord::Base
  has_secure_password
  # Assoscitions
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  has_many :photos


  # Validations
  validates :password,
            :length => {:in => 6..15}
  validates :password, :first_name, :last_name, :gender, :birthday, :email,
            :presence => true
  validates :email,
            :uniqueness => :true
  validates :first_name, :last_name,
            :length => {:in => 2..20}

  # Methods
  def full_name
    first_name + " " + last_name
  end

  def friends_with?(user)
    if friendships.where(:friend_id => user.id)
      true
    else
      false
    end

  end

end
