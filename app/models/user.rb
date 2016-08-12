class User < ApplicationRecord
  has_many :posts, :through => :activities, :source => :postable, :source_type => 'Post'
  has_many :comments_made, :through => :activities, :source => :postable, :source_type => 'Comment'
  has_many :activities, foreign_key: :author_id, dependent: :destroy
  has_many :liked_things, class_name: "Liking"

  before_create :generate_token
  has_secure_password

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :first_name, presence: true, :length => { :in => 1..24 }
  validates :last_name, presence: true, :length => { :in => 1..24 }
  validates :gender, presence: true
  validates :birthday, presence: true

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

  def fullname
    "#{first_name} #{last_name}"
  end

  def get_wall_activities
    activities.where.not(postable_type: "Comment").order(id: :desc)
  end

  def day
    val = birthday.strftime("%-d") || @current_user.birthday.strftime("%-d")
    val.to_s
  end

  def month
    val = birthday.strftime("%-m") || @current_user.birthday.strftime("%-m")
    val.to_s
  end

  def year
    val = birthday.strftime("%Y") || @current_user.birthday.strftime("%Y")
    val.to_s
  end

end
