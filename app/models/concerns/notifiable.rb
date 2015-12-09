module Notifiable
  extend ActiveSupport::Concern

  included do
    after_create :queue_notification_email
  end

  def queue_notification_email
    self.class.delay.send_notification_email(id)
  end

  class_methods do
    def send_notification_email(id)
      record = self.find_by_id(id)
      if record
        method = self.name.underscore.to_sym
        NotificationMailer.send(method, record).deliver!
      end
    end
  end
end

