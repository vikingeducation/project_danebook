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

end
