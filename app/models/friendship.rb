class Friendship < ActiveRecord::Base

  belongs_to :friend_requestor, :foreign_key => :friender_requestor_id,
                                :class_name => "User"


  belongs_to :friend_receiver,  :foreign_key => :friend_receiver_id,
                                :class_name => "User"

  validates :friend_requestor_id, :uniqueness => { :scope => :friend_receiver_id }

end
