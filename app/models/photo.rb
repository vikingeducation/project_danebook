class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable

  def photo_data=(photo_data)
    self.data = photo_data.read
    self.filename = photo_data.original_filename
    self.mime_type = photo_data.content_type
  end

end
