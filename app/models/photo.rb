class Photo < ActiveRecord::Base
  include Dateable

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
end
