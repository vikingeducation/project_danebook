module Friendable
  extend ActiveSupport::Concern

  included do
    belongs_to :initiator, :class_name => 'User'
    belongs_to :approver, :class_name => 'User'

    validate :enforce_unique_user_pair
    validate :enforce_frozen_ids, :on => :update
  end

  class_methods do
    def find_by_user(user)
      find_by_user_id(user.id)
    end

    def find_by_user_id(user_id)
      where('initiator_id = ? OR approver_id = ?', user_id, user_id)
    end

    def find_by_users(*users)
      raise ArgumentError, "Wrong number of arguments, expected 2 got #{users.length}" unless users.length == 2
      find_by_user_ids(*users.map(&:id))
    end

    def find_by_user_ids(*ids)
      raise ArgumentError, "Wrong number of arguments, expected 2 got #{ids.length}" unless ids.length == 2
      id_one = ids[0]
      id_two = ids[1]
      logic = 'initiator_id = ? AND approver_id = ?'
      where(
        "#{logic} OR #{logic}",
        id_one, id_two, id_two, id_one
      )
    end
  end


  private
  def enforce_unique_user_pair
    friendables = self.class.find_by_user_ids(initiator_id, approver_id)
    if friendables.present? && friendables.pluck(:id).exclude?(id)
      errors.add(:base, "A #{self.model_name.human.downcase} already exists with that #{initiator.model_name.human.downcase} pair")
    end
  end

  def enforce_frozen_ids
    if initiator_id_changed? || approver_id_changed?
      errors.add(:base, "Cannot alter the #{initiator.model_name.human.downcase} of a #{self.model_name.human.downcase}")
    end
  end
end

