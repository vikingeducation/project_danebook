class Profile < ActiveRecord::Base
include ProfilesHelper

  belongs_to :user
  has_many :photos
  
  #Photos part
  has_attached_file :avatar, :styles => { :thumb => "100x100" }
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment :avatar, :presence => true,
  :content_type => { :content_type => "image/jpeg" },
  :size => { :in => 0..1.megabytes }

  #Methods
  def to_s
    user.first_name + " " + user.last_name
  end

  def upload
    uploaded_io = params[:profile][:avatar]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      # Note that we're using the `read` method
      file.write(uploaded_io.read)
    end
  end

  def serve
    @user = User.find(params[:user_id])
    send_data(@user.avatar, filename: "avatar.jpg", disposition: 'inline')

  end
end
