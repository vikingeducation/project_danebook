module AdapterAcknowledgeable
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def adapter
      self.connection.instance_values["config"][:adapter]
    end
  end
end