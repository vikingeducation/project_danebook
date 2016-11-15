module Feedable
  extend ActiveSupport::Concern

  included do
    has_many :activities, :as => :feedable, :dependent => :destroy

    after_create :feedable_created
    after_update :feedable_updated
    after_destroy :feedable_destroyed
  end

  def feedable_created
    create_activity(:create)
  end

  def feedable_updated
    create_activity(:update)
  end

  def feedable_destroyed
    create_activity(:destroy)
  end

  def create_activity(verb)
    if self.class.feedable_actions.include?(verb)
      methods = self.class.feedable_user_methods
      methods.each do |method|
        Activity.create!(
          :user => self.send(method),
          :feedable => self,
          :verb => verb
        )
      end
    end
  end

  class_methods do
    def feedable_user_methods(*methods)
      @feedable_user_methods = methods if methods.present?
      @feedable_user_methods
    end

    def feedable_actions(*actions)
      @feedable_actions = actions if actions.present?
      @feedable_actions
    end
  end
end


