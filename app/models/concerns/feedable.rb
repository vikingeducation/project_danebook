module Feedable
  extend ActiveSupport::Concern

  included do
    has_many :activities, :as => :feedable, :dependent => :destroy

    after_create :feedable_created
    after_update :feedable_updated
    after_destroy :feedable_destroyed
  end

  def feedable_created
    create_activity(:create) if self.class.feedable_actions.include?(:create)
  end

  def feedable_updated
    create_activity(:update) if self.class.feedable_actions.include?(:update)
  end

  def feedable_destroyed
    create_activity(:destroy) if self.class.feedable_actions.include?(:destroy)
  end

  def create_activity(verb)
    Activity.create!(
      :user => self.send(self.class.feedable_user_method),
      :feedable => self,
      :verb => verb
    )
  end

  class_methods do
    def feedable_user_method(method=nil)
      @feedable_user_method = method unless method.nil?
      @feedable_user_method
    end

    def feedable_actions(*actions)
      @feedable_actions = actions if actions.present?
      @feedable_actions
    end
  end
end


