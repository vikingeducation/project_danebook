class User < ActiveRecord::Base

	has_one 	:profile, :dependent => :destroy
	has_many 	:posts
	# likes are polymorphic
	has_many 	:likes
	has_many 	:posts_liked_by_users, through: :likes, source: :post

	has_many :comments

	has_secure_password

	has_many :initiated_friendships,
						foreign_key: :initiator_id,
						class_name: 'Friendship'
	has_many :friends_added,
						through: :initiated_friendships,
						source: :friend_acceptor

	has_many :accepted_friendships,
						foreign_key: :acceptor_id,
						class_name: 'Friendship'
	has_many :friends_accepted,
						through: :accepted_friendships,
						source: :friend_initiator

	validates :password,
						:presence => true,
						:length => {:in => 4..24}
	validates :email,
						:format => {:with => /@/},
						:uniqueness => true
 	validates :first_name, :last_name, :presence => true

 	after_create :create_profile

	def full_name
		first_name + " " + last_name
	end

	def friends
		accepted_friendships.
		where(status: 'Accepted').
		joins('JOIN users on users.id = initiator_id').
		select(:users)
	end

	def accepted_friends
		initiated_friendships.where(status: 'Accepted') +
		accepted_friendships.where(status: 'Accepted')
	end

	def pending_friends
		accepted_friendships.where(status: 'Pending')
	end

private

end
