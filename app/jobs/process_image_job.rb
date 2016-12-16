class ProcessImageJob < ApplicationJob
  queue_as :default

  def perform(img)
    # Do something later
    PullTempfile.transaction(url: img.url, original_filename: File.basename(URI.parse(img.url).path)) do |tmp_image|
      img.picture = tmp_image
      if img.save
        obj = S3_BUCKET.objects.each do |obj|
          obj.delete if obj.key == url.gsub(/^(?:\/\/|[^\/]+)*\//, "")
        end
        self.url = nil
        save
      end
    end
  end
end
