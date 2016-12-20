class Image < ApplicationRecord
  before_save :file_or_url
  after_create :set_job

  attr_reader :set_profile_photo

  belongs_to :gallery, inverse_of: :images
  belongs_to :post, optional: true, dependent: :destroy

  has_one :user, through: :gallery

  has_attached_file :picture, styles: {large: '500x500>', medium: '300x300>', thumb: "100x100>"}, default_url: 'https://s3-us-west-1.amazonaws.com/danebook-sampson-crowley-dev/uploads/1/images/original/loading.svg'

  validates_attachment_content_type :picture, content_type: /\Aimage.*\Z/

  process_in_background :picture

  has_one :profile, dependent: :nullify

  before_post_process :randomize_file_name
  after_post_process :create_post

  def randomize_file_name
    unless url and url != ""
      extension = File.extname(picture_file_name).downcase
      self.picture.instance_write(:file_name, "#{SecureRandom.hex}-#{picture_file_name.downcase}")
    end
  end

  def set_profile_photo=(bool)
    if bool == "1"
      AddToProfilePhotosJob.perform_later self.id
    end
  end

  def copy_to_profile_photos
    if self.user.profile.profile_gallery.images.any? {|pgi| pgi.picture_file_name == self.picture_file_name }
      self.user.profile.update_attribute(:profile_img, self)
    else
      new_copy = self.user.profile.profile_gallery.images.build(picture: self.picture)
      new_copy.save
      self.user.profile.fix_profile_image
    end
  end
  # handle_asynchronously :set_profile_photo

  def create_post
    self.url = nil
    AutoPoster.new_image(self)
  end
  handle_asynchronously :create_post

  def file_or_url
    url = nil if url == ""
    picture_file_name = File.basename(URI.parse(self.url).path) if url
    picture = nil if url
  end

  def set_job
    if self.url && self.url != ""
      ProcessImageJob.perform_later self.id
    end
  end

  def process_img
    PullTempfile.transaction(url: self.url, original_filename: "#{SecureRandom.hex}-#{File.basename(URI.parse(self.url).path).downcase}") do |tmp_image|
      self.picture = tmp_image
      self.url = nil
      unless save
        profile = self.profile
        messages = self.errors.full_messages.select {|e| e !~ /Paperclip/}
        messages << "Make sure you are using a web-safe image."
        Notice.create(user: self.gallery.user, title: "Image Processing Failed", messages: messages )
        self.destroy
        profile.fix_profile_image if profile
      end
    end
  end
  # handle_asynchronously :process_img
end
