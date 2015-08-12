class Profile < ActiveRecord::Base
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_attached_file :profile_pic, styles: {small: '150x150'}
  validates_attachment_content_type :profile_pic, :content_type => /\Aimage\/.*\Z/
  has_attached_file :cover_pic, styles: {large: '1080x400'}, default_url: 'https://lh4.googleusercontent.com/2xuY-di5SzGyHX4sdPdfyX0IJVF-1T2Ea1__e5DYbNaIao8TisOf0nBgIJNT3Y6ZfMawOP1jI_R2y-xr4y7EMyHr70s-U1yZsemmDjn16irK5Q9ALK4BjKLEZ4z36Pc-XF0kWcg' 
  validates_attachment_content_type :cover_pic, :content_type => /\Aimage\/.*\Z/

  def email
    self.user.email
  end

  def birthday
    self.user.birthday
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
