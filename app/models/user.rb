class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :nullify
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users, through: :initiated_friendings, source: :friend_recipient
  has_many :received_friendings, :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by, through: :received_friendings, source: :friend_initiator

  accepts_nested_attributes_for :profile
  accepts_nested_attributes_for :posts

  before_create :generate_token
  after_create :create_profile

  has_secure_password

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true
  validates :first_name, :last_name,
            :presence => true,
            :length => { :minimum => 1 }#,
            # :allow_nil => true
  validates :birth_date,
           :presence => true#,
          #  :allow_nil => true

  validates :email, presence: true,
            length: { in: 4..40}

  validates_format_of :email, :with => /@/


  def full_name
    "#{self.first_name.capitalize} #{self.last_name.capitalize}"
  end

  def recent_user_posts
    self.posts.order(:updated_at => :desc)
  end

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

end
