class Photo < ActiveRecord::Base
  include Dateable
  include Feedable

  feedable_user_method :user
  feedable_actions :create

  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  has_many :likes, :as => :likeable, :dependent => :destroy

  has_attached_file :file, :styles => {:medium => "300x300", :thumb => "100x100"}

  validates :user,
            :presence => true

  validates_attachment  :file,
                        :presence => true,
                        :content_type => {:content_type => /\Aimage\/.*\Z/},
                        :size => {:in => 0..2.megabytes}

  before_destroy  :nullify_if_profile_photo,
                  :nullify_if_cover_photo

  def nullify_if_profile_photo
    if user.profile_photo_id == id
      user.profile_photo_id = nil
      user.save!
    end
  end

  def nullify_if_cover_photo
    if user.cover_photo_id == id
      user.cover_photo_id = nil
      user.save!
    end
  end
end
