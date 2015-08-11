class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :likes, 
           :as => :likable,
           :dependent => :destroy

  has_attached_file :user_photo, 
                    :styles => { :medium => "300x300", 
                                 :thumb  => "100x100" }
  validates_attachment_content_type :user_photo, 
                                    :content_type => /\Aimage\/.*\Z/


  def likes_by(user)
    likes.where(user_id: user.id).includes(:user)
  end

  def liked_by?(user)
    likes_by(user).any?
  end

  def get_id_of_the_like_by(user)
    liked_by?(user) ? likes_by(user).pluck(:id)[0] : nil
  end
end
