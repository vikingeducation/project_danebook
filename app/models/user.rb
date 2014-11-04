class User < ActiveRecord::Base
	before_create :generate_token
	has_secure_password

	has_one :profile

	has_many :posts, foreign_key: :author_id, dependent: :destroy
	has_many :comments, foreign_key: :author_id, dependent: :destroy
	has_many :photos, foreign_key: :author_id, dependent: :destroy
	has_many :likes, foreign_key: :user_id, dependent: :destroy

	validates :password, length: {in: 8..24}, allow_nil: true
	validates :email, uniqueness: true

	# Friends
  has_many :initiated_friendings, :foreign_key => :friender_id,
                                  :class_name => "Friending"
  has_many :friended_users,       :through => :initiated_friendings,
                                  :source => :friend_recipient

  has_many :received_friendings,  :foreign_key => :friend_id,
                                  :class_name => "Friending"
  has_many :users_friended_by,    :through => :received_friendings,
                                  :source => :friend_initiator

  validates :fname, :lname, :email, presence: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 8 },
                       allow_nil: true


	def name
		"#{fname} #{lname}"
	end

	def generate_token
		begin
		  self[:auth_token] = SecureRandom.urlsafe_base64
		end while User.exists?(auth_token: self[:auth_token])
	end

	def regenerate_auth_token
		self.auth_token = nil
		generate_token
		save!
	end

end