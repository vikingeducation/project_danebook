class Photo < ActiveRecord::Base
  belongs_to :author,
             class_name: 'User',
             foreign_key: 'user_id'
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_attached_file :image,
                    styles: { medium: '300x300', thumb: '150x150' },
                    default_url: '/images/missing.png'
  validates_attachment_content_type :image,
                                    content_type: /\Aimage\/.*\Z/

  def recent_likes
    get_recent_likes.map { |like| like.user.to_s }.join(', ')
  end

  def get_recent_likes
    likes.order('id DESC').limit(3)
  end
end
