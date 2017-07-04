module EmailHelper

  def attach_image_inline(image_obj)
    attachments.inline[image_obj.asset_file_name] = File.read(Rails.root.to_s + "/public" + image_obj.asset.url(:thumb).split("?").first)
    attachments.inline[image_obj.asset_file_name]
  end

end
