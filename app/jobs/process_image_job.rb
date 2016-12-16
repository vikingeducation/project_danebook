class ProcessImageJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    img = Image.find_by(id: id)
    img.process_img
  end
end
