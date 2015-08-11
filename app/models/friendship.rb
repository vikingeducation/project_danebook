class Friendship < ActiveRecord::Base

  belongs_to :friend_initiator,
              foreign_key: :initiator_id,
              class_name: 'User'

  belongs_to :friend_acceptor,
              foreign_key: :acceptor_id,
              class_name: 'User'

  validates :initiator_id,
             uniqueness: {scope: :acceptor_id}
end
