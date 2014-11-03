class Friending < ActiveRecord::Base

  belongs_to :friender, :class_name => "User", :foreign_key => :friender_id

  belongs_to :friendee, :class_name => "User", :foreign_key => :friendee_id

  after_create :delete_friend_request
  after_create :create_inverse

  before_destroy :destroy_inverse


  private

  def delete_friend_request
    if friender.friends_requested.include?(friendee)
      friender.friends_requested.delete(friendee)
    elsif friendee.friends_requested.include?(friender)
      friendee.friends_requested.delete(friender)
    end
  end

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
