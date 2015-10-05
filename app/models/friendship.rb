class Friendship < ActiveRecord::Base

  belongs_to :friend_initiator,
              foreign_key: :initiator_id,
              class_name: 'User'

  belongs_to :friend_acceptor,
              foreign_key: :acceptor_id,
              class_name: 'User'

  validates :initiator_id,
             uniqueness: {scope: :acceptor_id}


  def is_a_friend?(current_visitor)
    friend_acceptor == current_visitor ||
    friend_initiator == current_visitor
  end

  def is_you?(current_visitor, page_owner)
    friend_acceptor   ==  current_visitor  &&
    friend_initiator  ==  page_owner       ||
    friend_acceptor   ==  page_owner       &&
    friend_initiator  ==  current_visitor
  end

end
