class Image < ApplicationRecord
  after_create :set_job

  attr_reader :remote_url

  belongs_to :gallery, inverse_of: :images

  has_attached_file :picture, styles: {large: '500x500>', medium: '300x300>', thumb: "100x100>"}, default_url: 'https://s3-us-west-1.amazonaws.com/danebook-sampson-crowley-dev/uploads/1/images/original/loading.svg'

  validates_attachment_content_type :picture, content_type: /\Aimage.*\Z/

  has_one :profile, dependent: :nullify

  def set_job
    ProcessImageJob.perform_later self.id
  end

  def process_img
    PullTempfile.transaction(url: self.url, original_filename: File.basename(URI.parse(self.url).path)) do |tmp_image|
      self.picture = tmp_image
      obj = S3_BUCKET.objects.each do |obj|
        obj.delete if obj.key == self.url.gsub(/^(?:\/\/|[^\/]+)*\//, "")
      end
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
