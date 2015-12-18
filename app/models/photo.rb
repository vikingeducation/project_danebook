class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments,
           :as => :commentable,
           :dependent => :destroy
  has_many :likes, 
           :as => :likable,
           :dependent => :destroy

  has_attached_file :user_photo, 
                    :styles => { :medium => "300x300", 
                                 :thumb  => "100x100" }
  validates_attachment_content_type :user_photo, 
                                    :content_type => /\Aimage\/.*\Z/
                                    
  # concerns to get id of the like on this likable object                                 
  include GetLikeID
end
