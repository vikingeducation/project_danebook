class Friending < ActiveRecord::Base

  belongs_to :friender, :class_name => "User", :foreign_key => :friender_id
  belongs_to :friendee, :class_name => "User", :foreign_key => :friendee_id


  # friendships supercede and destroy the friend requests that precipitate them
  after_create :delete_friend_request


  # friendships are RECIPROCAL in this app
  # when Friend B accepts friendship with Friend A,
  # Friend A gets a friendship with Friend B back
  after_create :create_inverse
  before_destroy :destroy_inverse


  private

  # goes through both sides of the friendship and deletes any existing
  # friend requests
  def delete_friend_request
    if friender.friends_requested.include?(friendee)
      friender.friends_requested.delete(friendee)
    elsif friendee.friends_requested.include?(friender)
      friendee.friends_requested.delete(friender)
    end
  end

  # checks if inverse has already been created so as not to start an infinite cycle
  def create_inverse
    unless Friending.find_by(:friender_id => friendee.id, :friendee_id => friender.id)
      Friending.create(:friender_id => friendee.id, :friendee_id => friender.id)
    end
  end

  def destroy_inverse
    if inverse = Friending.find_by(:friender_id => friendee.id, :friendee_id => friender.id)
      inverse.destroy
    end
  end
end
