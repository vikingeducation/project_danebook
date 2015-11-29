module Friendable
  extend ActiveSupport::Concern

  included do
    belongs_to :initiator, :class_name => 'User'
    belongs_to :approver, :class_name => 'User'
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
end

