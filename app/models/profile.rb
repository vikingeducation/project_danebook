class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_attached_file :profile_pic, styles: {small: '150x150'}
  validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/

  def email
    self.user.email
  end

  def avatar_url
    if self.profile_pic.url != "/profile_pics/original/missing.png"
      self.profile_pic.url 
    else
      "https://robohash.org/#{self.user_id}"
    end
  end


  def missing_url
    "/profile_pics/original/missing.png"
  end
end
