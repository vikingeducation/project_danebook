module InvalidMacros

  def invalid_attributes(obj, field)
    invalid_attributes = [nil, "", " "]
    invalid_attributes.each do |attribute|
      obj.send(field, attribute)
      expect(obj).not_to be_valid
    end
  end
end