class Posting < ApplicationRecord
  belongs_to :postable, polymorphic: true
  belongs_to :user

  validates :user, presence: true
  validates :postable, presence: true

  def self.current_user_activities(user)
    ids = [user.id]
    self.joins("LEFT OUTER JOIN posts ON postings.postable_id = posts.id").
    joins("LEFT OUTER JOIN photos ON postings.postable_id = photos.id").
    where(user_id: [ids]).
    order(created_at: :desc)
  end

  def self.friend_activities(user)
    ids = user.friended_user_ids + [user.id]
    self.joins("LEFT OUTER JOIN posts ON postings.postable_id = posts.id").
    joins("LEFT OUTER JOIN photos ON postings.postable_id = photos.id").
    where(user_id: [ids]).
    order(created_at: :desc)
  end
end
