class Photo < ActiveRecord::Base
  belongs_to :user

  has_attached_file :file, :styles => {:medium => "300x300", :thumb => "100x100"}

  validates :user,
            :presence => true

  validates_attachment  :file,
                        :presence => true,
                        :content_type => {:content_type => /\Aimage\/.*\Z/},
                        :size => {:in => 0..2.megabytes}

  # http://bideowego.com/favicon-194x194.png
end
