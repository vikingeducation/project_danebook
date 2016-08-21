class Posting < ActiveRecord::Base
  belongs_to :postable, polymorphic: true
  belongs_to :user


  def self.activities(user)
    user_friend_ids = user.friended_users.pluck(:id)
    self.joins("LEFT OUTER JOIN posts ON postings.postable_id = posts.id").
    joins("LEFT OUTER JOIN photos ON postings.postable_id = photos.id").
    where(user_id: [user_friend_ids]).
    order(created_at: :desc)
  end

  def name
    postable_type.downcase
  end
end
