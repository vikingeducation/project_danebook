class Photo < ActiveRecord::Base
  belongs_to :profile

  has_attached_file :photo, :styles => { :thumb => ["32x32#", :png] }
  validates_attachment_content_type :photo, :content_type => /\Aimage\/.*\Z/
  validates_attachment :photo, :presence => true,
  :content_type => { :content_type => "image/jpeg" },
  :size => { :in => 0..10.megabytes }

  def upload
    uploaded_io = params[:photo]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      # Note that we're using the `read` method
      file.write(uploaded_io.read)
    end
  end

  def serve
    @user = User.find(params[:user_id])
    send_data(@user.avatar, filename: "photo.jpg", disposition: 'inline')

  end

  def added_on
    "Added on " + self.photo_updated_at.strftime("%A %m/%d/%Y")
  end
end
