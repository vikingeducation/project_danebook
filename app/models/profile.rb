class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy

  def email
    self.user.email
  end

  def avatar_url
    "https://robohash.org/#{self.user_id}"
  end
end
