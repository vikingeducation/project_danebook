class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  accepts_nested_attributes_for :comments, :likes, allow_destroy: true

  def photo_data=(photo_data)
    self.data = photo_data.read
    self.filename = photo_data.original_filename
    self.mime_type = photo_data.content_type
  end

  def liked?(user=nil)
    if user
      target = user.id
      likes.where(user_id: target).any?
    else
      likes.any?
    end
  end

  def like(user=nil)
    output = user ? likes.where(user_id: user.id) : likes
    output.last
  end

end
