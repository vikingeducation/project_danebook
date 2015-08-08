class User < ActiveRecord::Base

  # ----------------------- Associations --------------------

  has_one :profile, dependent: :destroy

  has_many :posts, -> { order('created_at DESC') },
            dependent: :destroy,
            foreign_key: :author_id,
            class_name: "Post"

  has_many :posts_received, -> { order('created_at DESC') },
            dependent: :destroy,
            foreign_key: :recipient_user_id,
            class_name: "Post"

  has_many :comments, dependent: :destroy, foreign_key: :author_id

  has_many :likes, dependent: :destroy

  has_secure_password

  # accepts_nested_attributes_for :profile

  # When acting as the initiator of the friending
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient

  # When acting as the recipient of the friending
  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator

  # ----------------------- Validations --------------------

  validates :first_name, :last_name,
            :length => { :in => 1..30 },
            presence: true

  validates :email,
            :format => { :with => /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i },
            length: { in: 6..30 },
            presence: true,
            uniqueness: true

  validates :password,
            :length => { :in => 8..24 },
            :allow_nil => true

  before_create :generate_token

  # ----------------------- Methods --------------------

  def name
    "#{first_name} #{last_name}"
  end

  def friended_by?(user)
    Friending.find_by({friend_id: self.id, friender_id: user.id })
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
