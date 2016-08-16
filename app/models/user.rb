class User < ApplicationRecord
  has_many :posts, :through => :activities, :source => :postable, :source_type => 'Post'
  has_many :comments_made, :through => :activities, :source => :postable, :source_type => 'Comment'
  has_many :activities, foreign_key: :author_id, dependent: :destroy
  has_many :liked_things, class_name: "Liking"

  has_many :initiated_friendings, foreign_key: :initiator_id, class_name: "Friending"
  has_many :followees, through: :initiated_friendings, source: :reciever

  has_many :recieved_friendings, foreign_key: :reciever_id, class_name: "Friending"
  has_many :followers, through: :recieved_friendings, source: :initiator

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
    val = self.birthday.strftime("%-d") if self.birthday
    val.to_s
  end

  def month
    val = self.birthday.strftime("%-m") if self.birthday
    val.to_s
  end

  def year
    val = self.birthday.strftime("%Y") if self.birthday
    val.to_s
  end

  def current_friend?(user_id)
    followee_ids.include? user_id.to_i
  end

  def this_friend(user_id)
    initiated_friendings.find_by_reciever_id(user_id)
  end
end
