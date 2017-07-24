class Friending < ApplicationRecord

  belongs_to :friend_initiator, :class => 'User',
                                :foreign_key => :friender_id

  belongs_to :friend_recipent,  :class => 'User',
                                :foreign_key => :friend_id


end
