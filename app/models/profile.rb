class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy

  def email
    self.user.email
  end
end
