class Profile < ActiveRecord::Base
include ProfilesHelper
  belongs_to :cover, class_name: "Photo"
  belongs_to :avatar, class_name: "Photo"
  belongs_to :user
  has_many :photos
  
  validates :user_id, uniqueness: true

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
