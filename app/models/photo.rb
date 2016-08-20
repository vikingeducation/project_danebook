class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :user, dependent: :nullify
  has_many :postings, as: :postable
  has_many :likes, :as => :likeable
  has_many :likers, through: :likes, source: :user
  has_many :comments, :as => :commentable
  has_many :commenters, through: :comments, source: :user

  has_attached_file :file, :styles => { :large => "600x600", :medium => "300x300", :thumb => "100x100" }

  validates_length_of :description, maximum: 500
  validates_attachment_content_type :file, :content_type => /\Aimage\/.*\Z/

  def self.to_s
    "photo"
  end

  def to_s
    "photos"
  end

  def self.activity(users_friends)
    joins("JOIN postings ON postings.postable_id = photos.id").where(postings: {postable_type: "Photo", user_id: [users_friends]})
  end
end
