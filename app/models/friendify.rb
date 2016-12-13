class Friendify
  class << self
    def friendship(user, friend)

      if user.id == friend.id

        [
          :danger,
          [
            "You can't friend yourself!",
            "Lonely Bastard..."
          ]
        ]

      elsif friends?(user, friend)

        [
          :danger,
          ["You're Already Friends!"]
        ]

      elsif accepting_request?(user, friend)

        accept_request(user, friend)

      else

        send_request(user, friend)

      end
    end

    def clear_request(user, friend)

      FriendRequest.
      where(user_id: user.id, request_id: friend.id).
      or(FriendRequest.
      where(user_id: friend.id, request_id: user.id)
      ).
      destroy_all

    end

    private

      def accept_request(user, friend)

        clear_request(user, friend)

        set_friends(user, friend)

        [
          :success,
          ["Friend Request Accepted!"]
        ]

      end


      def send_request(user, friend)

        request = FriendRequest.new(user_id: friend.id, request_id: user.id)

        if request.save

          [
            :success,
            ["Friend Request Sent!"]
          ]

        else

          [
            :danger,
            ["Friend Request Already Sent. Stop buggin them!"]
          ]

        end
      end

      def accepting_request?(user, friend)
        friend.requested_friends.include?(user)
      end

      def friends?(user, friend)
        user.friends.include?(friend)
      end


      def set_friends(user, friend)

        user.friends << friend

        friend.friends << user

      end
  end
end
