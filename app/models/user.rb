class User < ApplicationRecord

  before_create :generate_token

  has_secure_password

  has_many :photos
  has_one :cover
  has_one :cover_photo, :through => :cover, :source => :photo
  has_one :profile
  has_one :profile_photo, :through => :profile, :source => :photo
  def self.search(query)
    if query.nil? || query == ""
      where("")
    else
      where("first_name LIKE ? OR last_name LIKE ?", "%#{query}%", "%#{query}%")
    end
  end

  def current_cover
    self.cover_photo ? self.cover_photo.data.url(:thumb) : image_path('user.jpg')
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def bday_string
    "#{self.b_month}/#{self.b_day}/#{self.b_year}"
  end

  validates :password,
            :length => { :in => 3..24 },
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

  has_many :posts, :foreign_key => :author_id, :inverse_of => :author
  accepts_nested_attributes_for :posts,
                              :reject_if => :all_blank,
                              :allow_destroy => true

  has_many :comments, :foreign_key => :commenter_id, :inverse_of => :commenter

  has_many :initiated_friendings, :foreign_key => :friender_id,
                                 :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                 :source => :friend_recipient

 # When acting as the recipient of the friending
  has_many :received_friendings,  :foreign_key => :friend_id,
                                 :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                 :source => :friend_initiator

  def friends
    (self.friended_users + self.users_friended_by).uniq
  end

  def photo_count
    self.photos.count
  end
end
