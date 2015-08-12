class User < ActiveRecord::Base

  before_create :generate_token
  after_create :build_profile, :if => Proc.new{ self.profile.nil? }

  has_secure_password

  validates :email, :presence => true,
                    :uniqueness => true,
                    :format => { :with => /([\w\.-]+)@([\w\.-]+)\.([a-z\.]{2,6})/ }

  validates :password, :presence => true,
                        :length => {:in => 8..25},
                        :on => [:create, :update],
                        :allow_nil => true

  validates :birthdate, :presence => true

  validates :first_name, :last_name, :presence => true,
                                    :length => {:in => 1..30},
                                    :format => {:with => /[a-zA-Z]+/}

  has_one :profile,   dependent: :destroy
  has_many :posts,    dependent: :destroy
  has_many :likings,  through: :posts
  has_many :likes,    dependent: :destroy

  has_many :photos,   dependent: :destroy
  belongs_to :profile_photo, class_name: "Photo",
                            foreign_key: :profile_photo_id
  belongs_to :cover_photo, class_name: "Photo",
                            foreign_key: :cover_photo_id

  # person who want to be friends
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient

  # person being friended
  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator

  accepts_nested_attributes_for :profile, :reject_if => :all_blank

  def friends
    #currently one-way initiated_friendings list
    friended_users
  end

  def match_like(params)
    likes.where("likings_id = ? AND likings_type = ?", params[:likings_id], params[:likings_type]).first
    # fail
  end

  def full_name
    self.first_name + " " + self.last_name
  end


  #sign in cookies!
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
