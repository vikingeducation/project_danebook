class Photo < ApplicationRecord
  belongs_to :user
  has_attached_file :data, :styles => { :medium => "300x300", :thumb => "100x100" }

  validates_attachment_content_type :data, :content_type => /\Aimage\/.*\Z/

  has_one :cover
  has_one :cover_user, :through => :cover, :source => :user
  has_one :profile
  has_one :profile_user, :through => :profile, :source => :user

  has_many :likes, :as => :likable
  has_many :likers, :through => :likes

  has_many :comments, :as => :commentable, :inverse_of => :commentable
  has_many :commenters, :through => :comments
  accepts_nested_attributes_for :comments,
                              :reject_if => :all_blank,
                              :allow_destroy => true
end
