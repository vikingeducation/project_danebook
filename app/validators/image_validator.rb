class ImageValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless  [".jpg", ".png", ".gif", ".bmp", ".svg", ".rif"].include?(value[-4..-1]) ||
            [".jpeg", ".jfif", "tiff"].include?(value[-5..-1])
      record.errors[attribute] << (options[:message] || "must end in a valid image format")
    end
  end
end