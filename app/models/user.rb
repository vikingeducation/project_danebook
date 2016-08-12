class User < ApplicationRecord
  has_many :posts
  has_one :profile, dependent: :nullify
  has_many :photos

  before_create :generate_token
  after_create :create_profile
  has_secure_password

  validates :password, 
            :length => { :in => 5..20 }, 
            :allow_nil => true 
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
          
  accepts_nested_attributes_for :profile

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

  def all_posts
    self.posts.all.order('created_at DESC')
  end

end
