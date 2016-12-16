class Image < ApplicationRecord
  after_create :process_img

  attr_reader :remote_url

  belongs_to :gallery, inverse_of: :images

  has_attached_file :picture, styles: {large: '500x500>', medium: '300x300>', thumb: "100x100>"}, default_url: 'https://s3-us-west-1.amazonaws.com/danebook-sampson-crowley-dev/uploads/1/images/original/loading.svg'

  validates_attachment_content_type :picture, content_type: /\Aimage\/*\Z/

  # def set_job
  #   ProcessImageJob.perform_later self
  # end

  def process_img
    PullTempfile.transaction(url: self.url, original_filename: File.basename(URI.parse(self.url).path)) do |tmp_image|
      self.picture = tmp_image
      obj = S3_BUCKET.objects.each do |obj|
        obj.delete if obj.key == self.url.gsub(/^(?:\/\/|[^\/]+)*\//, "")
      end
      if save
        self.url = nil
        save
      else
        Notice.create(user: self.gallery.user, message: "Image Processing Failed. Make sure you are using a web-safe image")
        Image.find(self).destroy
      end
    end
  end
  handle_asynchronously :process_img
end
