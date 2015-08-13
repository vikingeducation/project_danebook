class Photo < ActiveRecord::Base
  has_attached_file :picture, :styles => { :medium => "350x350>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :picture, :content_type => /\Aimage\/.*\Z/
   validates_attachment_size :picture, :less_than => 2.megabytes

  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  belongs_to :user


  def already_liked_by?(current_user)
    return false unless current_user
    self.likes.where(:user_id => current_user.id).count > 0
  end
end
